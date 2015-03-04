class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(:email, params[:email])
    if user && authenticate(params[:password])
      session[:user_id] = user.user_id
      redirect_to projects_url, notice: "Logged in"
    else
  end
end
