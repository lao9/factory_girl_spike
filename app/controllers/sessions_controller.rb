class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password]) && user.admin?
      flash[:success] = "Welcome, #{user.first_name}!"
      session[:user_id] = user.id
      redirect_to "/admin/dashboard"
    elsif user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome, #{user.first_name}!"
      session[:user_id] = user.id
      redirect_to user_path
    else
      flash[:danger] = "Invalid Username or Password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    redirect_to root_path
  end
end
