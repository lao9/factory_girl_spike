require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) {create(:category)}
  let(:category_with_items) {create(:category_with_items)}

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
