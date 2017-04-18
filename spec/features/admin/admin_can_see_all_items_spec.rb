require "rails_helper"
RSpec.feature "Admin index view"do
  before :each do
    @user = create(:user)
    @user.update_attributes(role: 'admin')

    statii = ["ordered", "paid", "completed", "cancelled"]
    orders = create_list(:order_item, 4)
    index = 0
    orders.each do |order|
      order.order.update(status: statii[index])
      index += 1
    end
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)
  end
  scenario "they can visit the index view" do
    visit "/admin/dashboard"
    click_on "View All Items"
    expect(current_path).to eq("/admin/items")
  end
  scenario "they can see all of the things" do
    visit admin_items_path
    expect(page).to have_selector('table tr', :count => Item.count)
    expect(page).to have_css("img[src*='#{Item.first.image_url}']")
    expect(page).to have_css("a[href*='#{item_path(Item.first)}']")
    expect(page).to have_content(Item.first.description)
    expect(page).to have_content("active")

  end
end
