require 'rails_helper'

RSpec.feature "User can add items to cart" do
  context "as a visitor" do
    scenario "user can add items to cart from index" do
      item = create(:item)
      visit items_path
      click_on "Add to Cart"
      expect(page).to have_content("Successfully added #{item.title} to your cart")
      click_on "View Cart"

      expect(current_path).to eq("/cart")
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_css("img[src*='#{item.image_url}']")
      expect(page).to have_content("Total Price: $#{item.price}")
      expect(page).to have_content("Total Quantity: 1")
    end
  end
end
