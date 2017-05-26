require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order_with_items) {create(:order_with_items)}

  describe "relationships" do
    it "has a many to many relationship with categories" do
      should have_many(:items).through(:order_items)
    end
    it "belongs to a user" do
      should belong_to(:user)
    end
    it "has valid factory with user association" do
      expect(order_with_items).to respond_to(:user)
      expect(order_with_items.user).to be_a(User)
    end
    it "has valid factory with items association" do
      expect(order_with_items).to respond_to(:items)
      expect(order_with_items.items.count).to eq(3)
      expect(order_with_items.items.first).to be_an(Item)
    end
  end
end
