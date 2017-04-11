class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to(request.referer)
  end

  def show
    @cart = Cart.new(session[:cart])
    @order_items = @cart.list
  end

end
