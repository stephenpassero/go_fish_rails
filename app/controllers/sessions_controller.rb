class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(name: params[:user][:name])
    if @user.save
      session[:current_user] = @user.id
      redirect_to game_index_path
    else
      render :new
    end
  end
end
