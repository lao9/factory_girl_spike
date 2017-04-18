require 'rails_helper'

feature "user checkout with address" do
  context "user address doesn't exist yet" do
    scenario "user checkouts out their cart" do
      item = create(:item)

      user = create(:user_without_address)

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
      select('Colorado', :from => 'user[state]')
      fill_in 'user[zipcode]', with: '80205'
      click_on 'Update Address'

      expect(current_path).to eq(confirmation_path)
      expect(page).to have_content("Please review and confirm your order:")
      click_on 'Confirm Order'
      expect(current_path).to eq(order_path(Order.last))
      expect(page).to have_content("Your order has been placed!")
    end
  end
  context "user address does exist" do
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

      expect(current_path).to eq(confirmation_path)
      expect(page).to have_content("Please review and confirm your order:")

      click_on 'Confirm Order'
      expect(current_path).to eq(order_path(Order.last))
      expect(page).to have_content("Your order has been placed!")
    end
    scenario "user can edit their address before checkout" do
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

      expect(current_path).to eq(confirmation_path)
      expect(page).to have_content("Please review and confirm your order:")
      expect(page).to have_content(user.street)
      expect(page).to have_content(user.city_state_zip)

      click_on 'Edit'

      expect(current_path).to eq(edit_user_path)
      expect(page).to have_content("Please enter your shipping address:")
      fill_in 'user[street]', with: "2641 Champa St"
      fill_in 'user[city]', with: "Denver"
      select('Colorado', :from => 'user[state]')
      fill_in 'user[zipcode]', with: '80205'
      click_on 'Update Address'

      expect(current_path).to eq(confirmation_path)
      expect(page).to have_content("Please review and confirm your order:")
      expect(page).to have_content("2641 Champa St")
      expect(page).to have_content("Denver, CO 80205")

      click_on 'Confirm Order'
      expect(current_path).to eq(order_path(Order.last))
      expect(page).to have_content("Your order has been placed!")
    end
  end
  context "access from not checkout" do
    scenario "user tries to access edit page" do
      user = create(:user)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit edit_user_path

      expect(page).to have_content("Please enter your shipping address:")
      fill_in 'user[street]', with: "2641 Champa St"
      fill_in 'user[city]', with: "Denver"
      select('Colorado', :from => 'user[state]')
      fill_in 'user[zipcode]', with: '80205'
      click_on 'Update Address'

      expect(current_path).to eq(user_path)
      expect(page).to have_content("2641 Champa St")
      expect(page).to have_content("Denver, CO 80205")
    end
    scenario "user tries to access confirmation page" do
      user = create(:user)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit confirmation_path

      expect(page).to have_content("You haven't checked out from your cart!")
      expect(page).to have_button("Click here to return to cart.")

      click_button "Click here to return to cart."

      expect(current_path).to eq(cart_path)
    end
  end
end
