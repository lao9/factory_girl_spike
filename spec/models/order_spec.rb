require 'rails_helper'

RSpec.describe Order, type: :model do
  #### Replace the Test Setup up with 1 factorie
  # 1. order_with_items


  attr_reader :order_with_items

  before :all do
    user = User.create(first_name: 'Barry',
      last_name:  'Manilow',
      email: 'barry123@hotmail.com',
      role: 'default')

    item_1 = Item.create(title: 'Orange',
      description: "It's a banana",
      price:        15.0,
      image_url:    '/fruits/yellow')

    item_2 = Item.create(title: 'String Cheese',
      description: "Ewww",
      price:        3.0,
      image_url:    '/gross/grosses')

    item_3 = Item.create(title: 'Bread',
      description: "It's bread",
      price:        25.0,
      image_url:    '/gluten/bread')

    items = [item_1, item_2, item_3]

    @order_with_items = Order.create(user: user)
    @order_with_items.items << items
  end

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
