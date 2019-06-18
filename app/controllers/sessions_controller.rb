class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create()
    @user = User.find_or_initialize_by(name: params[:user][:name])
    @user.save()
  end
end
