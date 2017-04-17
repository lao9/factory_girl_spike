require 'rails_helper'

RSpec.feature "Unauthenticated user cannot view private user or admin data" do
  scenario "browsing page as unauthenticated user" do
    item1 = create(:item)
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item1.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    click_on "Logout"

    visit cart_path
    expect(page).to have_content("Your cart is empty, as is your heart")

    visit items_path
    within("div#pickle_#{item1.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    expect(page).to have_button("Login or Create Account to Checkout")

    visit orders_path
    expect(page).to have_xpath("//img[@src='http://i.imgur.com/4zZv7CM.jpg']")

    visit admin_dashboard_path
    expect(page).to have_xpath("//img[@src='http://i.imgur.com/4zZv7CM.jpg']")

    visit admin_users_path
    expect(page).to have_xpath("//img[@src='http://i.imgur.com/4zZv7CM.jpg']")

  end
end
