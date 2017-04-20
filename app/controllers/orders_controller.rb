class OrdersController < ApplicationController
  before_action :set_order, only: [:update, :show]
  def index
    unless current_user
      render :file => 'public/404.html', :status => :not_found
    else
      @orders = Order.where(user_id: current_user.id)
    end
  end

  def create
    @order = Order.create(user_id: session[:user_id])
    @order.order_items << @cart.list
    session[:cart] = nil
    flash[:success] = "Your order has been placed!"
    redirect_to order_path(@order)
  end

  def show
    @order_items = @order.order_items
    @display_user = @order.user
  end

  def update
    @order.update(status: params[:status])
    redirect_back(fallback_location: root_path)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

end
