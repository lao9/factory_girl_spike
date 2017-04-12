require 'rails_helper'

RSpec.feature "User can create a new account" do
  context "when providing all information" do
    scenario "they are logged in successfully" do

      visit new_user_path

      fill_in "user[first_name]", with: "Dill"
      fill_in "user[last_name]", with: "Pickles"
      fill_in "user[email]", with: "dpickles@pickle.com"
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(user_path(User.last))

      expect(page).to have_content("Successfully logged in!")
      expect(page).to have_content("Dill Pickles")

      expect(page).to_not have_content("Login")
      expect(page).to_not have_content("Sign Up")
    end
    scenario "they provide an already existing email" do
      user = create(:user)
      redundant_email = user.email

      visit new_user_path

      fill_in "user[first_name]", with: "Dill"
      fill_in "user[last_name]", with: "Pickles"
      fill_in "user[email]", with: redundant_email
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("#{redundant_email} already taken!")

      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
    end
  end
  context "when providing not enough information" do
    # not sure if I need to/how to test this
    # might be something we can force in the form for
  end
end
