class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to restaurants_path, notice: "Signed up!"
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name )
  end
end
