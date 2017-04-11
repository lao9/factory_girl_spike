require 'rails_helper'

RSpec.feature "Vistor can remove item from cart" do
  scenario "visitor is in cart page populated with items" do
    item = create(:item)
    visit items_path
    click_on "Add to Cart"
    click_on "View Cart"

    click_on "Remove"
    expect(current_path).to eq(cart_path)
    expect(page).to have_content ("Successfully removed")
    expect(page).to have_link (item_path(item))
    expect(page).to_not have_content(item.description)
    expect(page).to_not have_content(item.price)
    expect(page).to_not have_css("img[src*='#{item.image_url}']")
  end
end
