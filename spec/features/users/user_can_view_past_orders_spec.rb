require "rails_helper"

RSpec.feature "Viewing past orders" do
  it "user with several past orders can view them" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item1.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    visit items_path

    within("div#pickle_#{item2.id}") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    visit items_path

    within("div#pickle_#{item3.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"

    visit orders_path

    expect(current_path).to eq(orders_path)
    within("table.table") do
      expect(page).to have_content("1")
      expect(page).to have_content("2")
      expect(page).to have_content("3")
    end
  end


  it "user cannot see others' past orders" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    user = create(:user)
    user2 = create(:user)


    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "Log In"

    visit items_path

    within("div#pickle_#{item1.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    visit items_path

    within("div#pickle_#{item2.id}") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    visit items_path

    within("div#pickle_#{item3.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"

    click_on "Logout"

    visit login_path
    fill_in "session[email]", with: user2.email
    fill_in "session[password]", with: user2.password
    click_button "Log In"

    visit orders_path

    expect(current_path).to eq(orders_path)
    within("table.table") do
      expect(page).to_not have_content("1")
      expect(page).to_not have_content("2")
      expect(page).to_not have_content("3")
    end
  end
end
