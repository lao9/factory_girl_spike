class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect_to user_path
    elsif User.find_by(email: @user.email)
      flash[:warning] = "#{@user.email} already taken!"
      redirect_to new_user_path
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:warning] = "Your password confirmation does not match"
      redirect_to new_user_path
    else
      flash[:warning] = "There was a problem creating your account. Please try again!"
      redirect_to new_user_path
    end
  end

  def show
    @display_user = current_user
  end

  def edit
    @display_user = current_user
    @post_url = check_path(request.referer)
  end

  def update
    current_user.update(user_address_params)
    if (params[:token] == confirmation_path) && current_user.save
      flash[:success] = "Please confirm your order."
      redirect_to confirmation_path
    elsif (params[:token] == user_path) && current_user.save
      flash[:success] = "Address Updated!"
      redirect_to user_path
    else
      flash[:warning] = "There was a problem adding your address. Please try again!"
      redirect_to edit_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user_address_params
    params.require(:user).permit(:street, :city, :state, :zipcode)
  end
end
