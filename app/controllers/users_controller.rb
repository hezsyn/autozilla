class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      flash[:error] = "Welcome, user account created"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash[:error] = "Logged out"
  end


  private
    def allowed_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
