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

# edge cases
# two different items to the cart
# add one item to the cart and confirm that when we go back and add
# maybe also add a flash meesage "you added this to your cart"

  # issueFour:
  #   title: Adding items to the cart
  #   body: >
  #     Background: Items, and a user that is not logged in
  #     As a visitor
  #     When I visit any page with an item on it
  #     I should see a link or button for "Add to Cart"
  #     When I click "Add to cart" for that item
  #     And I click a link or button to view cart
  #     And my current path should be "/cart"
  #     And I should see a small image, title, description and price for the item I just added
  #     And there should be a "total" price for the cart that should be the sum of all items in the cart
