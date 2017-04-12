require 'rails_helper'

describe "User can login" do
  before :each do
    @user = create(:user)
  end
  context "when using the navbar" do
    xscenario "user is directed to login page from navbar" do
      visit root

      click_on "Login"

      expect(current_path).to eq(login_path)
    end
  end
  context "when providing all information" do
    xscenario "they can log in" do
      visit login_path

      within("form") do
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_on "Login"
      end

      expect(current_path).to eq(user_path(@user))
      expect(page).to have_content("Successfully logged in!")
      expect(page).to have_content("Welcome, #{@user.first_name}l!")
      expect(page).to have_content("Logout")

      expect(page).to_not have_content "Sign Up"
      expect(page).to_not have_content "Login"
    end
  end
end
