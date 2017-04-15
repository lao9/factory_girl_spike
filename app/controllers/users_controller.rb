class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect_to user_path(@user)
    elsif User.find_by(email: @user.email)
      flash[:warning] = "#{@user.email} already taken!"
      redirect_to new_user_path
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:warning] = "Your password confirmation does not match"
      redirect_to new_user_path
    else
      flash[:warning] = "There was an problem creating your account. Please try again"
      redirect_to new_user_path
    end
  end

  def show
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
