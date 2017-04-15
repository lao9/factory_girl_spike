require 'rails_helper'

RSpec.describe Cart, type: :model do
  before :each do
    @cart = create(:cart)
    @item1 = create(:item)
    @item2 = create(:item)
  end
  describe "attributes" do
    it "has contents" do
      expect(@cart).to respond_to(:contents)
      expect(@cart.contents).to be_a Hash
      expect(@cart.contents["1"]).to eq(1)
    end
  end
  describe "methods" do
    it "can add new item to cart" do
      @cart.add_item(2)

      expect(@cart.contents).to eq({"1"=>1, "2"=> 1})
    end
    it "can new same item to cart" do
      @cart.add_item(1)

      expect(@cart.contents).to eq({"1"=>2})
    end
    it "can remove item from cart" do
      @cart.add_item(1)
      @cart.remove_item(1)

      expect(@cart.contents).to eq({"1"=>1})
    end
    it "can update item quantity in cart" do
      expect(@cart.contents["1"]).to eq(1)

      @cart.update(1, 3)

      expect(@cart.contents["1"]).to eq(3)
    end
    it "can list order item objects" do
      cart = Cart.new({@item1.id.to_s => 1})
      cart.add_item(@item2.id)
      cart.update(@item1.id, 3)

      expect(cart.list.count).to eq(2)
      expect(cart.list.first).to be_a OrderItem
      expect(cart.list.first.quantity).to eq(3)
      expect(cart.list.last.quantity).to eq(1)
    end

    it "can calculate cart total" do
      cart = Cart.new({@item1.id.to_s => 1})
      cart.add_item(@item2.id)
      cart.update(@item1.id, 3)
      total = "$%.2f" % ((@item1.price * 3) + @item2.price)

      expect(cart.cart_total).to eq(total)
    end
    it "can calculate cart quantity" do
      cart = Cart.new({@item1.id.to_s => 1})
      cart.add_item(@item2.id)
      cart.update(@item1.id, 3)

      expect(cart.cart_quantity).to eq(4)
    end
  end
end
