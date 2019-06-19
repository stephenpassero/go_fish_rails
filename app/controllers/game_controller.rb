class GameController < ApplicationController
  def create
    @game = Game.create(game_params)
    User.find(session[:current_user]).update(game_id: @game.id)
    redirect_to game_show_path(id: @game)
  end

  def index
    @user_name = User.find(session[:current_user]).name
    @pending_games = Game.pending
  end

  def new
    @game = Game.new()
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:players)
  end
end
