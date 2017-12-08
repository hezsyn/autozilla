class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, flash[:notice] = "Welcome, user account created"
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash[:notice] = "Logged out"
  end

end
