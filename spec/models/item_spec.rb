require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a title, description, image_url, price" do
    item = create(:item)

    expect(item).to respond_to(:title)
    expect(item).to respond_to(:description)
    expect(item).to respond_to(:image_url)
    expect(item).to respond_to(:price)
  end
end
