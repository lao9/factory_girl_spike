class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to(request.referer)
  end

  def index
    @cart = Cart.new(session[:cart])
    @order_items = @cart.list
  end

  def remove
    @item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.remove_item(params[:item_id])
    @cart.contents.delete_if { |k, v| v == 0 }

    flash[:success] = "Successfully removed #{view_context.link_to(@item.title, @item)} from your cart.".html_safe

    redirect_to carts_path
  end
end
