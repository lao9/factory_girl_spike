require 'rails_helper'

RSpec.feature "As a visitor with items in cart" do
  scenario "trying to checkout cart items without logging in" do
    item = create(:item)
    visit items_path
    click_on "Add to Cart"
    visit cart_path

    expect(page).to have_button "Login or Create Account to Checkout"
    expect(page).to_not have_css(".checkout")
    click_on "Login or Create Account to Checkout"
    expect(current_path).to eq(login_path) #or create account
    visit new_user_path

    fill_in "user[first_name]", with: "Dill"
    fill_in "user[last_name]", with: "Pickles"
    fill_in "user[email]", with: "dpickles@pickle.com"
    fill_in "user[password]", with: "rugrat2017"
    fill_in "user[password_confirmation]", with: "rugrat2017"

    click_on "See what the 'big dill' is about!"

    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_content("Dill Pickles")

    click_on "View Cart"
    expect(current_path).to eq(cart_path)
    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_button "Checkout"
    expect(page).to_not have_button "Login or Create Account to Checkout"


  end
end
