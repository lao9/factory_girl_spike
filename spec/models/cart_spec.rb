require 'rails_helper'

RSpec.describe Cart, type: :model do
  #### Replace the Test Setup up with 1 factories
  # 1. cart

  attr_reader :cart, :item1, :item2
  before :each do
    @item1 = Item.create(title: 'Monkey',
      description: "It's a banana",
      price:        15.0,
      image_url:    '/fruits/yellow')

    @item2 = Item.create(title: 'Lemur',
      description: "It's a banana",
      price:        15.0,
      image_url:    '/fruits/yellow')

    @cart = Cart.new({"#{@item1.id}" => 1})
  end

  describe "attributes" do
    it "factory has contents" do
      expect(cart).to respond_to(:contents)
      expect(cart.contents).to be_a Hash
      expect(cart.contents.keys.count).to eq(1)
      expect(cart.contents["#{item1.id}"]).to eq(1)
    end
  end
  describe "methods" do
    it "can add new item to cart" do
      cart.add_item(item2.id)

      expect(cart.contents).to eq({"#{item1.id}"=>1, "#{item2.id}"=> 1})
    end
    it "can new same item to cart" do
      cart.add_item(item1.id)

      expect(cart.contents).to eq({"#{item1.id}"=>2})
    end
  end
end
