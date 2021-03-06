class UsersController < ApplicationController
  def find_params
    User.find(params[:id])
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      auto_login(@user)
      redirect_to projects_url, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @product.update_attributes(user_params)
      redirect_to users_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :remember)
  end
end
