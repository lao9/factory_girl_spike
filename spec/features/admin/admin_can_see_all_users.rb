require 'rails_helper'

RSpec.feature 'Admin logs in' do
  context 'admin can see all users' do
    admin = User.create(first_name: "George", last_name: "Devenshire", email: "g@d.com", password: "password", role: 1)
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)

    visit login_path
    fill_in "session[email]", with: admin.email
    fill_in "session[password]", with: admin.password
    click_button "Log In"

    click_button "View All Users"

    expect(current_path).to eq(users_index_path)

    expect(page).to have_content(admin.first_name)
    expect(page).to have_content(admin.last_name)
    expect(page).to have_content(admin.email)
    expect(page).to have_content(user1.first_name)
    expect(page).to have_content(user1.last_name)
    expect(page).to have_content(user1.email)
    expect(page).to have_content(user2.first_name)
    expect(page).to have_content(user2.last_name)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.first_name)
    expect(page).to have_content(user3.last_name)
    expect(page).to have_content(user3.email)

    click_link(user1.email)

  end
end
