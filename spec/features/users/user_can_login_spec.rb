require 'rails_helper'

describe "User can login" do
  before :each do
    @user = create(:user)
  end
  context "when using the navbar" do
    scenario "user is directed to login page from navbar" do
      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)
    end
  end
  context "when providing all information" do
    scenario "they can log in" do
      visit login_path

      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_button "Log In"

      expect(current_path).to eq(user_path(@user))
      expect(page).to have_content("Welcome, #{@user.first_name}l!")
      expect(page).to have_content("Logout")

      expect(page).to_not have_content "Sign Up"
      expect(page).to_not have_content "Login"
    end
    scenario "they provide invalid email" do
      visit login_path

      fill_in "session[email]", with: "lollllll@lol.com"
      fill_in "session[password]", with: @user.password
      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Login"
    end
    scenario "they provide invalid password" do
      visit login_path

      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: "blah"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Login"
    end
  end
end
