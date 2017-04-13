require "rails_helper"

RSpec.feature "Viewing past orders" do
  it "user with several past orders can view them" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    user = create(:user)
    date = DateTime.now.strftime("%A %B %e, %Y, %l:%M %p")

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

    within("div#pickle_#{item2.id}.pickle") do
      click_on "Add to Cart"
    end
    click_on "View Cart"
    click_on "Checkout"
    visit orders_path

    within("table.table") do
      expect(page).to have_content("1")
      expect(page).to have_link("1")
      click_on "1"
    end

    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.price)
    # expect(page).to have_content(item1.price)   Search in correct xpath for subtotal

    page.has_selector?(:xpath, '/html/body/div[2]/div/table/tbody/tr[2]/td[4]')   #
    expect(page).to have_content("Total Price: $#{item1.price}")
    expect(page).to have_content("Purchase Date: #{date}")
    expect(page).to have_link(item1.title, href: item_path(item1))
    expect(page).to have_css("img[src*='#{item1.image_url}']")

    expect(page).to have_content("Current Status: ordered on #{date}")
  end
end
