require "rails_helper"


RSpec.feature "User cannot change own role" do
  it "user can't change their role" do
    user = create(:user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    expect(page).to_not have_button("Give yourself admin priviliges!")
  end
end
