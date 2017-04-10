require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a name" do
    category = create(:category)
    expect(category).to respond_to(:name)
  end
  it "can have items" do
    category = create(:category_with_items)
    expect(category).to respond_to(:items)
    expect(category.items.count).to eq(2)
    
  end

end
