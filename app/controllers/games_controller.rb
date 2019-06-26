class GamesController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    @game = Game.create(game_params)
    user = User.find(session[:current_user])
    GameUser.create(game_id: @game.id, user_id: user.id)
    redirect_to @game
  end

  def index
    user = User.find(session[:current_user])
    @user_name = user.name
    @pending_games = Game.pending
  end

  def new
    @game = Game.new()
  end

  def join
    game = Game.find(params[:format])
    user = User.find(session[:current_user])
    GameUser.create(game_id: game.id, user_id: user.id) unless game.users.include?(user)
    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
    if @game.users.length == @game.players && @game.start_at == nil
      @game.update(start_at: Time.now)
      @game.start
    end
    @player_name = User.find(session[:current_user]).name
    @initial_state = @game.game_logic.player_data(@player_name) if @game.game_logic
    respond_to do |format|
      format.html
      format.json { render :json => @initial_state }
    end
  end

  def leave
    User.find(session[:current_user]).update(game_id: nil)
    game = Game.find(params[:id])
    if game.users.length == 0
      game.delete
    end
    redirect_to games_path
  end

  def run_round
    game = Game.find(params[:gameId])
    player = game.game_logic.player_names[game.game_logic.player_turn - 1]
    target = params[:selectedOpponent]
    rank = params[:selectedRank]
    game.game_logic.run_turn(player, target, rank)
    game.save
    # Initiate pusher here
  end

  private

  def game_params
    params.require(:game).permit(:players)
  end
end
