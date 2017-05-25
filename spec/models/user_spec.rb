require 'rails_helper'

RSpec.describe User, type: :model  do
  let(:user) {create(:user)}
  let(:user_with_orders) {create(:user_with_orders)}

  describe "validations" do
    context "user is valid with all attributes" do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_presence_of(:role) }
      it { should have_secure_password }
      it { should validate_uniqueness_of(:email) }
    end
  end
  context "invalid" do
    it "is invalid without non-unique password" do
      redundant_email = user.email
      user2 = build(:user, email: redundant_email)

      expect(user2).to_not be_valid
    end
  end

  describe "attributes" do
    it "has default value of default for user role" do
      expect(user.role).to eq "default"
    end
  end

  describe "relationships" do
    it "has many orders" do
      should have_many(:orders)
    end
    it "has valid factory with orders association" do
      expect(user_with_orders).to respond_to(:orders)
      expect(user_with_orders.orders.count).to eq(2)
      expect(user_with_orders.orders.first).to be_a(Order)
    end
    it "should have orders with many items" do
      order = user_with_orders.orders.first

      expect(order).to respond_to(:items)
      expect(order.items.count).to eq(2)
      expect(order.items.first).to be_an(Item)
    end
  end
end
