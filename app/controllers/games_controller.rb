class GamesController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    @game = Game.create(game_params)
    if @game.errors.any?
      redirect_to new_game_path, notice: 'There must be more players than there are bots'
    else
      user = User.find(session[:current_user])
      GameUser.create(game_id: @game.id, user_id: user.id)
      pusher_client.trigger("game", 'new-game', {
        message: "A new game has been created"
      })
      redirect_to @game
    end
  end

  def index
    user = User.find(session[:current_user])
    @user_name = user.name
    @pending_games = Game.pending
    @in_progress_games = Game.in_progress.select {|game| game.users.include?(user)}
    @finished_games = Game.finished.select {|game| game.users.include?(user)}
  end

  def new
    @game = Game.new()
  end

  def join
    game = Game.find(params[:format])
    user = User.find(session[:current_user])
    GameUser.create(game_id: game.id, user_id: user.id) unless game.users.include?(user)
    pusher_client.trigger("game", 'player-joined', {
      game_id: game.id,
      user_id: "#{user.id}"
    })
    redirect_to game
  end

  def end
    game = Game.find(params[:id])
    game.end
  end

  def show
    @game = Game.find(params[:id])
    if @game.waiting_for_players == 0 && @game.start_at == nil
      @game.start
    end
    if @game.game_logic && @game.end_at == nil && @game.game_logic.winner? == true
      @game.end
    end
    @player_name = User.find(session[:current_user]).name
    @initial_state = @game.game_logic.player_data(@player_name) if @game.game_logic
    respond_to do |format|
      format.html
      format.json { render :json => @initial_state }
    end
  end

  def leave
    game = Game.find(params[:id])
    GameUser.find_by(user: session[:current_user], game_id: game.id).destroy
    if game.users.length == 0
      game.destroy
    end
    pusher_client.trigger("game", 'new-game', {
      message: "Somebody left a game"
    })
    pusher_client.trigger("game", 'player-left', {
      user_id: "#{session[:current_user]}",
      game_id: game.id
    })
    redirect_to games_path
  end

  def run_round
    game = Game.find(params[:gameId])
    player = game.game_logic.player_names[game.game_logic.player_turn - 1]
    target = params[:selectedOpponent]
    rank = params[:selectedRank]
    game.game_logic.run_turn(player, target, rank)
    game.save
    pusher_client.trigger("game#{game.id}", 'turn-played', {
      message: "#{player} ran a turn"
    })
  end

  private

  def game_params
    params.require(:game).permit(:players, :bots)
  end
end
