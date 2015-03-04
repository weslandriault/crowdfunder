class SessionsController < ApplicationController

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      session[:user_id] = @user.id
      redirect_to projects_url, notice: "Logged in"
    else
      flash.now[:alert] = "Invalid email or password!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to projects_url, notice: "Logged out!"
  end
end
