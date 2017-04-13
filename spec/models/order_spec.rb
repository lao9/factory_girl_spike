require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @order = create(:order_with_many_items)
  end
  describe "relationships" do
    it "has a many to many relationship with categories" do
      should have_many(:items).through(:order_items)
    end
  end
  describe "methods" do
    it "can return an order date" do
      @order.update(created_at: DateTime.new(2017,4,13,12,36))
      exp_date = "Thursday April 13, 2017,  6:36 AM"
      expect(@order.order_date).to be_a String
      expect(@order.order_date).to eq(exp_date)
    end
    it "can return a total price" do
      expect(@order.total_price).to eq(OrderItem.sum(:subtotal))
    end
    it "can return a total quantity" do
      expect(@order.total_quantity).to eq(OrderItem.sum(:quantity))
    end
  end
end
