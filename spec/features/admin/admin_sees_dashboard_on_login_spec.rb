require 'rails_helper'

RSpec.feature 'Admin logs in' do
  it 'admin sees the admin dashboard' do
    user = User.create(first_name: "George", last_name: "Devenshire", email: "g@d.com", password: "password", role: 1)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    expect(current_path).to eq("/admin/dashboard")

    expect(page).to have_link("Admin Dashboard")
    expect(page).to have_link("View All Users")

  end
end
