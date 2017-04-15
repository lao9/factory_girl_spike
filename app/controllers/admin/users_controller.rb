class Admin::UsersController < Admin::BaseController


  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def admin_dash
    # binding.pry
  end




end
