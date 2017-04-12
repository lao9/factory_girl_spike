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


  # issueTen:
  #   title: Viewing a past order
  #   body: >
  #     Background: An existing user that has one previous order
  #     As an authenticated user
  #     When I visit "/orders"
  #     Then I should see my past order
  #     And I should see a link to view that order
  #     And when I click that link
  #     Then I should see each item that was order with the quantity and line-item subtotals
  #     And I should see links to each item's show page







  #     And I should see the current status of the order **(ordered, paid, cancelled, completed)**
  #     And I should see the total price for the order
  #     And I should see the date/time that the order was submitted
  #     If the order was completed or cancelled
  #     Then I should see a timestamp when the action took place
