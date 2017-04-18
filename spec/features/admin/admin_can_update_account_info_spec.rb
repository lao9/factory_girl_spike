require 'rails_helper'

feature "admin can modify their account info" do
  before :each do
    @admin_user, @admin_user2 = create_list(:user, 2)
    @admin_user.update(role: 1)
    @admin_user2.update(role: 1)
    @user = create(:user)
  end
  scenario "admin can change their first name" do

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@admin_user)

    visit user_path

    expect(current_path).to eq(user_path)
    expect(page).to have_content(@admin_user.first_name)
    expect(page).to have_content(@admin_user.last_name)
    expect(page).to have_content(@admin_user.email)

    click_button "Edit Account Information"

    expect(current_path).to eq(edit_admin_user_path(@admin_user))
    new_first_name = "Tester"

    fill_in 'user[first_name]', with: new_first_name
    click_button "Update Account Info"

    expect(current_path).to eq(admin_user_path(@admin_user))
    expect(page).to have_content("Account successfully updated!")
    expect(page).to have_content(new_first_name)
    expect(page).to have_content(@admin_user.last_name)
    expect(page).to have_content(@admin_user.email)

    expect(User.find(@admin_user.id).first_name).to eq(new_first_name)
  end
  scenario "admin can change their last name" do

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@admin_user)

    visit user_path

    expect(current_path).to eq(user_path)
    expect(page).to have_content(@admin_user.first_name)
    expect(page).to have_content(@admin_user.last_name)
    expect(page).to have_content(@admin_user.email)

    click_button "Edit Account Information"

    expect(current_path).to eq(edit_admin_user_path(@admin_user))
    new_last_name = "Tester"

    fill_in 'user[last_name]', with: new_last_name
    click_button "Update Account Info"

    expect(current_path).to eq(admin_user_path(@admin_user))
    expect(page).to have_content("Account successfully updated!")
    expect(page).to have_content(@admin_user.first_name)
    expect(page).to have_content(new_last_name)
    expect(page).to have_content(@admin_user.email)

    expect(User.find(@admin_user.id).last_name).to eq(new_last_name)
  end
  scenario "admin can change their email and login with new email" do
    visit login_path

    fill_in "session[email]", with: @admin_user.email
    fill_in "session[password]", with: @admin_user.password
    click_button "Log In"

    click_link @admin_user.full_name

    expect(current_path).to eq(admin_user_path(@admin_user))
    expect(page).to have_content(@admin_user.first_name)
    expect(page).to have_content(@admin_user.last_name)
    expect(page).to have_content(@admin_user.email)

    click_button "Edit Account Information"

    expect(current_path).to eq(edit_admin_user_path(@admin_user))
    new_email = "test@test.com"

    fill_in 'user[email]', with: new_email
    click_button "Update Account Info"

    expect(current_path).to eq(admin_user_path(@admin_user))
    expect(page).to have_content("Account successfully updated!")
    expect(page).to have_content(@admin_user.first_name)
    expect(page).to have_content(@admin_user.last_name)
    expect(page).to have_content(new_email)

    expect(User.find(@admin_user.id).email).to eq(new_email)

    click_link "Logout"

    click_link "Login"

    fill_in "session[email]", with: new_email
    fill_in "session[password]", with: @admin_user.password
    click_button "Log In"

    expect(page).to have_content("Welcome, #{@admin_user.first_name}!")
  end
  scenario "admin cannot modify a users account info" do
    visit login_path

    fill_in "session[email]", with: @admin_user.email
    fill_in "session[password]", with: @admin_user.password
    click_button "Log In"

    visit admin_dashboard_path

    click_link "View All Users"

    expect(current_path).to eq(admin_users_path)

    click_link "#{@user.full_name}"

    expect(current_path).to eq(admin_user_path(@user))
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
    expect(page).to have_content(@user.email)
    expect(page).to_not have_button("Edit Account Information")
  end
  scenario "admin cannot modify another admin's account info" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@admin_user)

    visit admin_dashboard_path

    click_link "View All Users"

    expect(current_path).to eq(admin_users_path)

    click_link "#{@admin_user2.full_name}"

    expect(current_path).to eq(admin_user_path(@admin_user2))
    expect(page).to have_content(@admin_user2.first_name)
    expect(page).to have_content(@admin_user2.last_name)
    expect(page).to have_content(@admin_user2.email)
    expect(page).to_not have_button("Edit Account Information")
  end
end
