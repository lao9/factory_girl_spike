require 'rails_helper'

RSpec.feature "Cart is emptied" do
  scenario "When user logs out" do
    item = create(:item)
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item.id}.pickle") do
      click_on "Add to Cart"
    end

    click_on "View Cart"
    click_on "Logout"
    click_on "View Cart"

    expect(page).to_not have_content(item.title)
    expect(page).to_not have_content(item.description)
    expect(page).to_not have_content(item.price)
  end

  scenario "When user checks out" do
    item = create(:item)
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item.id}.pickle") do
      click_on "Add to Cart"
    end

    click_on "View Cart"
    click_on "Checkout"
    click_on "View Cart"

    expect(page).to_not have_content(item.title)
    expect(page).to_not have_content(item.description)
    expect(page).to_not have_content(item.price)
  end
end
