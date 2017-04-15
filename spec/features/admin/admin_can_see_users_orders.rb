require 'rails_helper'

RSpec.feature 'Admin logs in' do
  context 'user has orders' do
    scenario 'admin can see users orders'

    admin = User.create(first_name: "George", last_name: "Devenshire", email: "g@d.com", password: "password", role: 1)

    user = create(:user)
    item1 = create(:item)
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
    click_on "logout"






    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.price)

    page.has_selector?(:xpath, '/html/body/div[2]/div/table/tbody/tr[2]/td[4]')   #
    expect(page).to have_content("Total Price: $#{item1.price}")
    expect(page).to have_content("Purchase Date: #{date}")
    expect(page).to have_link(item1.title, href: item_path(item1))
    expect(page).to have_css("img[src*='#{item1.image_url}']")

    expect(page).to have_content("Current Status: ordered on #{date}")

















#################


    visit login_path
    fill_in "session[email]", with: admin.email
    fill_in "session[password]", with: admin.password
    click_button "Log In"

    click_button "View All Users"

    expect(current_path).to eq(users_index_path)

    expect(page).to have_content(admin.first_name)
    expect(page).to have_content(admin.last_name)
    expect(page).to have_content(admin.email)
    expect(page).to have_content(user1.first_name)
    expect(page).to have_content(user1.last_name)
    expect(page).to have_content(user1.email)
    expect(page).to have_content(user2.first_name)
    expect(page).to have_content(user2.last_name)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.first_name)
    expect(page).to have_content(user3.last_name)
    expect(page).to have_content(user3.email)

    click_link(user1.email)

  end
end
