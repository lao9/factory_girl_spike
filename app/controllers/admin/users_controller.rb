class Admin::UsersController < Admin::BaseController
  before_action :set_admin_user, only: [:show, :edit, :update]
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @display_user.update(admin_user_params)

    if @display_user.save
      flash[:success] = "Account successfully updated!"
      redirect_to admin_user_path(@display_user)
    else
      flash[:warning] = "Account unable to be updated."
      redirect_to edit_admin_user_path(@display_user)
    end
  end

  def admin_dash
    @orders =  Order
  end

  def analytics
    @orders = Order
    @users = User
    @items = Item
  end


  def sales_report
    OrderMailer.sales_report(params["Email"]).deliver
    flash[:success] = "Sales report sent to #{params["Email"]}"
    redirect_to admin_dashboard_path
  end

  private

  def admin_user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_admin_user
    @display_user = User.find(params[:id])
  end

end
