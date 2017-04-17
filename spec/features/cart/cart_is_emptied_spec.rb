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
    expect(page).to have_content("Your cart is empty, as is your heart...")
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
    mail =  ActionMailer::Base.deliveries.first
    expect(mail.from).to eq(["MrPickles@WeCanPickleThat.com"])
    expect(mail.subject).to eq("Your order has been placed")
    click_on "View Cart"

    expect(page).to_not have_content(item.title)
    expect(page).to_not have_content(item.description)
    expect(page).to_not have_content(item.price)
    expect(page).to have_content("Your cart is empty, as is your heart...")
  end
end
