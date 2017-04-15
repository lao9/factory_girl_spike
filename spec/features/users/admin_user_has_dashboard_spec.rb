require 'rails_helper'
RSpec.describe "A user can go to the admin/dashboard route" do
  before :each do
    @user = create(:user)
  end
  scenario "as an admin they see the admin dash" do
      @user.update_attributes(role: 'admin')
      visit login_path
      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_button "Log In"
      visit dashboard_path
      expect(page).to have_css('h1', 'Admin Dashboard')
  end
  scenario "as a registered user they see a 404" do
      visit login_path
      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_button "Log In"
      visit dashboard_path
      expect(page).to have_content('404')
  end
  scenario "as an unregistered user they see a 404" do
      visit dashboard_path
      expect(page).to have_content('404')
  end
end
# As an Admin
# When I visit "/admin/dashboard"
# I will see a heading on the page that says "Admin Dashboard"
# As a registered user
# When I visit "/admin/dashboard"
# I get a 404
# As an unregistered user
# When I visit "/admin/dashboard"
# I get a 404
