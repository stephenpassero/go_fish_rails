class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user
      session[:current_user] = @user.id
      redirect_to games_path
    else
      @user = User.create(name: params[:user][:name])
      if @user.errors.any?
        redirect_to '/', notice: 'Player name cannot start with “Bot”'
      else
        redirect_to games_path
      end
    end
  end
end
