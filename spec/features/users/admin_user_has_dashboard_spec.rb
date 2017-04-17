require 'rails_helper'
RSpec.describe "A user can go to the admin/dashboard route" do
  before :each do
    @user = create(:user)
  end
  scenario "as an admin they see the admin dash" do
    @user.update_attributes(role: 'admin')

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)

    visit admin_dashboard_path
    within('h1') do
      expect(page).to have_content('Admin Dashboard')
    end
  end
  scenario "as a registered user they see a 404" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)

    visit admin_dashboard_path
    expect(page).to have_content('404')
  end
  scenario "as an unregistered user they see a 404" do
      visit admin_dashboard_path
      expect(page).to have_content('404')
  end
end
