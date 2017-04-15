require "rails_helper"

RSpec.feature "Viewing past orders" do
  context "Authenticated user" do
    scenario "cannot see admin page" do
      user = create(:user)

      visit login_path
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_button "Log In"

      visit dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page).to have_content("You may have mistyped the address or the page may have moved.")
      expect(page).to have_button("View All Users")
    end
  end
end
