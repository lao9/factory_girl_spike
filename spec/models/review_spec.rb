require 'rails_helper'

RSpec.describe Review, type: :model do
  before :each do
    @review = create(:review)
  end
  it "has the attributes" do
    expect(@review).to respond_to(:title)
    expect(@review).to respond_to(:body)
    expect(@review).to respond_to(:rating)
    expect(@review.user).to eq(User.first)
    expect(@review.item).to eq(Item.first)
  end
  it "has the right relations" do
    should belong_to(:user)
    should belong_to(:item)
  end
end
