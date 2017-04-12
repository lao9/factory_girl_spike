require 'rails_helper'

feature "user profile" do
  scenario "user can see dashboard by clicking on their name" do
    user = create(:user)

    visit login_path

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(user_path(user))

    click_link "All Pickles"

    expect(current_path).to eq(items_path)

    click_link user.full_name

    expect(current_path).to eq(user_path(user))
  end
end
