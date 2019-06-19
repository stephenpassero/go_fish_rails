class GameController < ApplicationController
  def create
    @game = Game.create(game_params)
    redirect_to game_show_path(id: @game)
  end

  def index
    user = User.find(session[:current_user])
    @user_name = user.name
    @pending_games = Game.pending
  end

  def new
    @game = Game.new()
  end

  def show
    @game = Game.find(params[:id])
    User.find(session[:current_user]).update(game_id: @game.id)
  end

  def leave
    User.find(session[:current_user]).update(game_id: nil)
    game = Game.find(params[:id])
    if game.users.length == 0
      game.delete
    end
    redirect_to game_index_path
  end

  private

  def game_params
    params.require(:game).permit(:players)
  end
end
