require 'rails_helper'

RSpec.describe "A user can see a retired item" do
  it "they can't add the item to their cart" do
    item = create(:item)
    item.update_attributes!(retired: true)
    visit item_path(item)
    expect(current_path).to eq(item_path(item))
    expect(page).to_not have_content "Add to Cart"
    expect(page).to_not have_content "Item Retired"
  end
end



# As a user if I visit an item page and that item has been retired
# Then I should still be able to access the item page
# And I should not be able to add the item to their cart
# And I should see in place of the "Add to Cart" button or link - "Item Retired"
