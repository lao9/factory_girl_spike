require 'rails_helper'

RSpec.describe Item, type: :model do
  #### Replace the Test Setup up with 3 factories
  # 1. item
  # 2. item_with_categories
  # 3. item_with_orders

  attr_reader :item, :item_with_categories, :item_with_orders

  before :all do
    @item = Item.create(title:       'Banana',
      description: "It's a banana",
      price:        15.0,
      image_url:    '/fruits/yellow')

    category_1 = Category.create(name: 'Yellow')
    category_2 = Category.create(name:'Fruits')
    categories = [category_1, category_2]

    @item_with_categories = @item
    @item_with_categories.categories << categories

    @user = User.create(first_name: 'Barry',
      last_name:  'Manilow',
      email: 'barry123@hotmail.com',
      role: 'default')

    order_1 = Order.create(user: @user)
    order_2 = Order.create(user: @user)
    order_3 = Order.create(user: @user)
    orders = [order_1, order_2, order_3]

    @item_with_orders = @item
    @item_with_orders.orders << orders
  end

  describe "validations" do
    it { expect(item).to validate_presence_of(:price)}
    it { expect(item).to validate_presence_of(:description)}
    it { expect(item).to validate_presence_of(:title)}
    it { expect(item).to validate_uniqueness_of(:title)}
    it { expect(item).to validate_numericality_of(:price).is_greater_than(0)}
  end

  describe "attributes" do
    it "has a title, description, image_url, price" do
      expect(item).to respond_to(:title)
      expect(item).to respond_to(:description)
      expect(item).to respond_to(:image_url)
      expect(item).to respond_to(:price)
      expect(item).to respond_to(:retired)
    end
    it "has default value of false for retired" do
      expect(item.retired).to be false
    end
  end
  
  describe "relationships" do
    it "has a many to many relationship with categories" do
      should have_many(:categories).through(:category_items)
    end
    it "has a many to many relationship with order" do
      should have_many(:orders).through(:order_items)
    end
    it "has valid factory with categories association" do
      expect(item_with_categories).to respond_to(:categories)
      expect(item_with_categories.categories.count).to eq(2)
      expect(item_with_categories.categories.first).to be_a(Category)
    end
    it "has valid factory with orders association" do
      expect(item_with_orders).to respond_to(:orders)
      expect(item_with_orders.orders.count).to eq(3)
      expect(item_with_orders.orders.first).to be_a(Order)
    end
  end
end
