class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @order = Order.create(user_id: session[:user_id])
    @order.order_items << @cart.list
    redirect_to order_path(@order)
  end

  def show
    @order= Order.find(params[:id])
    @order_items = @order.order_items
  end
end
