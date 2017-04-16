class OrdersController < ApplicationController

  def index
    # binding.pry
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
    OrderMailer.new_order(@order.user, @order).deliver
    redirect_to order_path(@order)
  end

  def show
    @order= Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    order = Order.find(params[:id])
    order.update(status: params[:status])
    OrderMailer.update(order.user, order).deliver
    redirect_back(fallback_location: root_path)
  end

private



end
