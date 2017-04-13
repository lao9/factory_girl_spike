require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "attributes" do
    it "has contents" do
      cart = create(:cart)
      expect(cart.contents).to be_a Hash
    end
  end

#
#   describe "relationships" do
#     it "has a many to many relationship with items" do
#       should have_many(:items).through(:category_items)
#     end
#     it "has many items" do
#       category = create(:category_with_items)
#       item1, item2 = category.items
#
#       expect(category).to respond_to(:items)
#       expect(category.items.count).to eq(2)
#       expect(category.items).to eq([item1, item2])
#     end
#   end
# end


# class Cart
#
#   attr_reader :contents
#
#   def initialize(initial_contents)
#      @contents = initial_contents || {}
#      list
#   end
#
#   def add_item(item_id)
#     contents[item_id.to_s] ||= 0
#     contents[item_id.to_s] += 1
#   end
#
#   def remove_item(item_id)
#     contents[item_id.to_s] -= 1
#   end
#
#   def update(item_id, new_quantity)
#     contents[item_id.to_s] = new_quantity.to_i
#   end
#
#   def list
#     # contents.map { |item_id, quantity| OrderItem.new(Item.find(item_id), quantity) }
#     contents.map do |item_id, quantity|
#       OrderItem.new(item_id: item_id, quantity: quantity, subtotal: (quantity * Item.find(item_id).price))
#     end
#
#   end
#
#   def cart_total
#     list.reduce(0) do |sum, order_item|
#       sum + order_item.subtotal
#     end
#   end
#
#   def cart_quantity
#     list.reduce(0) do |sum, order_item|
#       sum + order_item.quantity
#     end
#   end
#
end
