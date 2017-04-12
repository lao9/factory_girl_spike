require 'rails_helper'

feature "user can view single item" do
  scenario "user visits item show page" do
    item = create(:item)

    visit item_path(item)

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.price)
    expect(page).to have_css("img[src*='#{item.image_url}']")
  end
  scenario "user can add item from show page" do
    item = create(:item)

    visit item_path(item)
    click_on "Add to Cart"

    expect(page).to have_content("Successfully added #{item.title} to your cart!")
  end
end
