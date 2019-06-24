class GamesController < ApplicationController
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
    if @game.users.length == @game.players
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

  private

  def game_params
    params.require(:game).permit(:players)
  end
end
