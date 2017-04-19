# issueNineteen:
# title: Admin views an individual Order
# body: >
# As an authenticated Admin, when I visit an individual order page
# Then I can see the order's date and time.
# And I can see the purchaser's full name and address.
# And I can see, for each item on the order:
# - The item's name, which is linked to the item page.
# - Quantity in this order.
# - Price
# - Line item subtotal.
# And I can see the total for the order.
# And I can see the status for the order.

require 'rails_helper'

feature "order show page" do
  before :each do
    @user = create(:user_with_orders)
    @admin = create(:user)
    @admin.update(role: 1)
    @order = @user.orders.first
    @order_item1, @order_item2 = @order.order_items
  end
  scenario "admin can view " do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@admin)

    visit admin_dashboard_path
    click_link @order.id

    expect(page).to have_content(@order.order_date)
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user.street)
    expect(page).to have_content(@user.city_state_zip)
    expect(page).to have_link(@order_item1.item.title)
    expect(page).to have_content(@order_item1.item.price)
    expect(page).to have_content(@order_item1.quantity)
    expect(page).to have_content(@order_item1.subtotal)
    expect(page).to have_content(@order.total_price)
    expect(page).to have_content(@order.total_quantity)
    expect(page).to have_content(@order.status)
  end
end
