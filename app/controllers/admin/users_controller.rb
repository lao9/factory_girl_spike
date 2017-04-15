class Admin::UsersController < Admin::BaseController


  def index
    @users = User.all
  end

  def show
    @viewed_user = User.find(params[:id])
  end

  def admin_dash
    @ordered = Order.where(status: "ordered")
    @paid = Order.where(status: "paid")
    @completed = Order.where(status: "completed")
    @cancelled = Order.where(status: "cancelled")
  end




end
