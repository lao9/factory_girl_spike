require 'rails_helper'

RSpec.feature "User can create a new account" do
  context "when using the navbar" do
    scenario "user is directed to sign up page from navbar" do
      visit root_path

      click_on "Sign Up"

      expect(current_path).to eq(new_user_path)
    end
  end
  context "when providing all information" do
    scenario "they are logged in successfully" do

      visit new_user_path

      fill_in "user[first_name]", with: "Dill"
      fill_in "user[last_name]", with: "Pickles"
      fill_in "user[email]", with: "dpickles@pickle.com"
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(user_path)

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
    scenario "they provide everything except email" do
      visit new_user_path

      fill_in "user[first_name]", with: "Dill"
      fill_in "user[last_name]", with: "Pickles"
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("There was a problem creating your account. Please try again!")

      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
    end
    scenario "they provide everything except first name" do
      visit new_user_path

      fill_in "user[last_name]", with: "Pickles"
      fill_in "user[email]", with: "dpickles@pickle.com"
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("There was a problem creating your account. Please try again!")

      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
    end
    scenario "they provide everything except last name" do
      visit new_user_path

      fill_in "user[first_name]", with: "Dill"
      fill_in "user[email]", with: "dpickles@pickle.com"
      fill_in "user[password]", with: "rugrat2017"
      fill_in "user[password_confirmation]", with: "rugrat2017"

      click_on "See what the 'big dill' is about!"

      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("There was a problem creating your account. Please try again!")

      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
    end
  end
end
