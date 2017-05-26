require 'rails_helper'

RSpec.describe User, type: :model  do
  #### REPLACE WHAT'S BELOW ME ...
  # Create two factories:
  # 1. user
  # 2. user_with_orders
  attr_reader :user, :user_with_orders
  before :all do
    category = Category.create(name:"Vegetable")
    category.items.create(title: "Orange Cumin Carrots",
      description: "Pickled carrots with a bit of Eastern spice.",
      price: 8,
      image_url: "cumin_carrots.jpg")
    category.items.create(title: "Ginger Beets",
      description: "A delicious combination on flavors",
      price: 7,
      image_url: "ginger_beets.jpg")
    category.items.create(title: "Pickled Peppers",
      description: "Get dat spice and tang.",
      price: 6,
      image_url: "ginger_beets.jpg")
    item1, item2, item3 = category.items
    @user = User.create(first_name: "Edward",
      last_name: "Donutbaker",
      email: "a1@a.com",
      password: "password")
    @user_with_orders = User.create(first_name: "Albert",
      last_name: "Dibbins",
      email: "a2@a.com",
      password: "password")
    @user_with_orders.orders
      .create.order_items
      .create(item: item1, quantity: 1, subtotal: item1.price)
    @user_with_orders.orders
      .last.order_items
      .create(item: item2, quantity: 2, subtotal: (item2.price * 2))
    @user_with_orders.orders
      .last.order_items
      .create(item: item3, quantity: 3, subtotal: (item3.price * 2))
    @user_with_orders.orders
      .create.order_items
      .create(item: item1, quantity: 1, subtotal: item1.price)
    @user_with_orders.orders
      .last.order_items
      .create(item: item2, quantity: 2, subtotal: (item2.price * 2))
    @user_with_orders.orders
      .last.order_items
      .create(item: item3, quantity: 3, subtotal: (item3.price * 2))
  end
  #### REPLACE WHAT'S ABOVE ME ...
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
      # REPLACE BELOW TOO...
      user2 = User.create(first_name: "Diana",
        last_name: "Crivvens",
        email: redundant_email,
        password: "password")
      # REPLACE ABOVE WITH SOMETHING ...

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
    it "has valid factory with items associated with its orders" do
      order = user_with_orders.orders.first

      expect(order).to respond_to(:items)
      expect(order.items.count).to eq(3)
      expect(order.items.first).to be_an(Item)
    end
  end
end
