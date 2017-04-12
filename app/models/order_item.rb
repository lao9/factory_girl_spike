class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # attr_reader :item, :quantity, :subtotal

  # def initialize(item, quantity)
  #   @item = item
  #   @quantity = quantity
  #   @subtotal = quantity * item.price
  # end


end
