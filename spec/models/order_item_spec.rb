require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before :each do
    @order_item = create(:order_item)
  end
  describe "attributes" do
    it "has a quantity and subtotal" do
      expect(@order_item).to respond_to(:quantity)
      expect(@order_item).to respond_to(:subtotal)
    end
  end

  describe "relationships" do
    it "belongs to an item" do
      should belong_to(:item)
      expect(@order_item).to respond_to(:item)
      expect(@order_item.item).to eq(Item.first)
    end
    it "belongs to an order" do
      should belong_to(:order)
      expect(@order_item).to respond_to(:order)
      expect(@order_item.order).to eq(Order.first)
    end
  end

end
