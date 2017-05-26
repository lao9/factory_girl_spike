require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) {create(:cart)}
  let(:item1) {create(:item, id: 1)}
  let(:item2) {create(:item, id: 2)}

  describe "attributes" do
    it "factory has contents" do
      expect(cart).to respond_to(:contents)
      expect(cart.contents).to be_a Hash
      expect(cart.contents.keys.count).to eq(1)
      expect(cart.contents["1"]).to eq(1)
    end
  end
  describe "methods" do
    it "can add new item to cart" do
      cart.add_item(item2.id)

      expect(cart.contents).to eq({"1"=>1, "2"=> 1})
    end
    it "can new same item to cart" do
      cart.add_item(item1.id)

      expect(cart.contents).to eq({"1"=>2})
    end
  end
end
