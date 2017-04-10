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

    # binding.pry
    # @items =
    # Item.find(session[:cart][]
  end

  # session[:return_to] ||= request.referer
  # Then redirect to it in your update action, after a successful save:
  #
  # redirect_to session.delete(:return_to)

end
