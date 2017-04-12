require 'rails_helper'

RSpec.feature "User can log out" do
  scenario "user is logged in and clicks logout" do
    user = create(:user)
    visit login_path

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    click_on "Logout"
    expect(page).to have_link("Login")
    expect(page).to_not have_link("Logout")
  end
end
