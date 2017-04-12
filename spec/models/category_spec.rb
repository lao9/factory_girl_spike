require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "attributes" do
    it "responds to name" do
      category = create(:category)
      expect(category).to respond_to(:name)
    end
  end

  describe "relationships" do
    it "has a many to many relationship with items" do
      should have_many(:items).through(:category_items)
    end
    it "has many items" do
      category = create(:category_with_items)
      item1, item2 = category.items

      expect(category).to respond_to(:items)
      expect(category.items.count).to eq(2)
      expect(category.items).to eq([item1, item2])
    end
  end
end
