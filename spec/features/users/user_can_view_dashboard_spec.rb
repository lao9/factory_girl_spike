require 'rails_helper'

feature "user profile" do
  scenario "user can see dashboard by clicking on their name" do
    user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    click_link "All Pickles"

    expect(current_path).to eq(items_path)

    click_link user.full_name

    expect(current_path).to eq(user_path)
  end
end
