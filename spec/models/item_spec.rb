require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "attributes" do
    it "has a title, description, image_url, price" do
      item = create(:item)

      expect(item).to respond_to(:title)
      expect(item).to respond_to(:description)
      expect(item).to respond_to(:image_url)
      expect(item).to respond_to(:price)
    end
  end

  describe "relationships" do
    it "has a many to many relationship with categories" do
      should have_many(:categories).through(:category_items)
    end
    it "has many categories" do
      item = create(:item_with_categories)
      category1, category2 = item.categories

      expect(item).to respond_to(:categories)
      expect(item.categories.count).to eq(2)
      expect(item.categories).to eq([category1, category2])
    end
  end
end
