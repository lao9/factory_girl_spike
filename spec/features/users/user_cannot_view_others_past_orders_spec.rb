require "rails_helper"

RSpec.feature "Viewing past orders" do
  scenario "user cannot see others' past orders or cart" do
    user1, user2 = create_list(:user_with_orders, 2)
    order1, order2 = user1.orders
    order3, order4 = user2.orders

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user1)

    visit orders_path

    expect(current_path).to eq(orders_path)

    within(".table") do
      expect(page).to have_link(order1.id)
      expect(page).to have_link(order2.id)
      expect(page).to_not have_link(order3.id)
      expect(page).to_not have_link(order4.id)
    end

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user2)

    visit orders_path

    expect(current_path).to eq(orders_path)
    within(".table") do
      expect(page).to_not have_link(order1.id)
      expect(page).to_not have_link(order2.id)
      expect(page).to have_link(order3.id)
      expect(page).to have_link(order4.id)
    end
  end
  scenario "user cannot see others' cart" do
    user1, user2 = create_list(:user_with_orders, 2)
    item1 = Item.first

    visit login_path
    fill_in "session[email]", with: user1.email
    fill_in "session[password]", with: user1.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item1.id}.pickle") do
      click_on "Add to Cart"
    end

    click_on "View Cart"

    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.price)

    click_on "Logout"
    visit login_path
    fill_in "session[email]", with: user2.email
    fill_in "session[password]", with: user2.password
    click_button "Log In"

    click_on "View Cart"

    expect(page).to_not have_content(item1.title)
    expect(page).to_not have_content(item1.description)
    expect(page).to_not have_content(item1.price)
    expect(page).to have_content("Your cart is empty, as is your heart...")
  end
end
