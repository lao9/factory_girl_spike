require 'rails_helper'

RSpec.describe Category, type: :model do
  #### REPLACE WHAT'S BELOW ME ...
  # Create two factories:
  # 1. category
  # 2. category_with_items
  attr_reader :category, :category_with_items
  before :all do
    @category = Category.create(name:"Dill")
    @category_with_items = Category.create(name:"Spicy")
    @category_with_items.items.create(title: "Assorted Peppers",
      description: "A variety of spicy peppers. Adds a little zip to any dish.",
      price: 8,
      image_url: "assorted_peppers_jar.jpg")
    @category_with_items.items.create(title: "McClures Spicy",
      description: "These classic spicy pickles have just the right amount of bite.",
      price: 7,
      image_url: "mcclures_jar.jpg")
  end
  #### REPLACE WHAT'S ABOVE ME ...
  describe "attributes" do
    it "responds to name" do
      expect(category).to respond_to(:name)
    end
  end

  describe "validations" do
    it { expect(category).to validate_presence_of(:name)}
  end

  describe "relationships" do
    it "has a many to many relationship with items" do
      should have_many(:items).through(:category_items)
    end
    it "has valid factory with items association" do
      expect(category_with_items).to respond_to(:items)
      expect(category_with_items.items.count).to eq(2)
      expect(category_with_items.items.first).to be_a(Item)
    end
  end
end
