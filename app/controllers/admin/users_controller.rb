class Admin::UsersController < Admin::BaseController


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def admin_dash
  end




end
