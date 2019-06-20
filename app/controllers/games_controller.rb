class GamesController < ApplicationController
  def create
    @game = Game.create(game_params)
    User.find(session[:current_user]).update(game_id: @game.id)
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
    User.find(session[:current_user]).update(game_id: game.id)
    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
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
