require 'rails_helper'

RSpec.feature "Admin Dashboard"do
  before :each do
    @user = create(:user)
    @user.update_attributes(role: 'admin')
    order1, order2, order3 = create_list(:order_with_many_items, 3)
  end
  scenario "shows order information" do
    visit login_path
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_button "Log In"
    visit dashboard_path
    expect(page).to have_content("All Orders")
    
  end
end


# When I visit the dashboard
# Then I can see a listing of all orders
# And I can see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed")
# And I can see a link for each individual order
# And I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed")
# And I have links to transition between statuses
# - I can click on "cancel" on individual orders which are "paid" or "ordered"
# - I can click on "mark as paid" on orders that are "ordered"
# - I can click on "mark as completed" on orders that are "paid"
