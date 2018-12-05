class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])      
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      flash[:notice] = "Welcome, user account created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])   
  end

  def update
    @user = User.find(params[:id])

    if @user.update?
      flash[:notice] = "Congrats, #{user.name} has been updated."
      redirect_to user_path(@user)
    else 
      flash[:notice] = "That failed..."
      redirect_to user_path(@user)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash[:notice] = "Logged out"
  end


  private
    def allowed_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
