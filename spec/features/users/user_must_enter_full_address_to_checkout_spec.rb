require 'rails_helper'

feature "user checkout with address" do
  context "user address doesn't exist yet" do
    scenario "user checkouts out their cart" do
      item = create(:item)

      user = create(:user)

      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on 'Log In'

      visit items_path
      click_on "Add to Cart"
      expect(page).to have_content("Successfully added #{item.title} to your cart")
      click_on "View Cart"

      click_on "Checkout"

      expect(current_path).to eq(edit_user_path)
      expect(page).to have_content("Please enter your shipping address:")
      fill_in 'user[street]', with: "2641 Champa St"
      fill_in 'user[city]', with: "Denver"
      select 'CO', from:'user[state]'
      fill_in 'user[zip]', with: '80205'
      click_on 'Complete Checkout'

      expect(current_path).to eq(order_path(Order.last))
    end
  end
  context "user address does exist" do
    xscenario "user checkouts out their cart" do
      item = create(:item)
      user = create(:user)

      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on 'Log In'

      visit items_path
      click_on "Add to Cart"
      expect(page).to have_content("Successfully added #{item.title} to your cart")
      click_on "View Cart"

      click_on "Checkout"

      expect(current_path).to eq(order_path(Order.last))
    end
  end
end
