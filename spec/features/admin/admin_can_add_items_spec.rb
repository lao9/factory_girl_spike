require "rails_helper"


RSpec.feature "Admin can create items" do
  context "Item is valid" do
    scenario "Admin fills out title, description, price, and image_url" do
      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)
      Category.create(name: "Briney")

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Title", with: "Pickle"
      fill_in "Description", with: "It's green"
      fill_in "Price", with: 4.00
      fill_in "item_image_url", with: "http://images.wisegeek.com/cornichons-in-a-jar.jpg"

      check "Briney"
      # find(:css, "#Category[value='Briney']").set(true)

      # Uncheck
      # find(:css, "#cityID[value='62']").set(false)


      click_on "Create Item"

      expect(Item.count).to eq(1)
      expect(page).to have_content("Pickle Successfully Created!")
      expect(page).to have_content("Pickle")
      expect(page).to have_content("It's green")
      expect(page).to have_content("$4.00")
      expect(page).to have_xpath("//*[@id='pickle_1']/img")
    end

    scenario "pickles are given a default image" do
      user = create(:user)
      user.admin!
      Category.create(name: "Briney")

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Title", with: "Double Dill"
      fill_in "Description", with: "It's green"
      fill_in "Price", with: 4.00

      check "Briney"

      click_on "Create Item"

      expect(page).to have_content("Pickle Successfully Created!")
      expect(page).to have_content("Double Dill")
      expect(page).to have_content("It's green")
      expect(page).to have_content("$4.00")
      expect(page).to have_xpath("//*[@id='pickle_2']/img")
    end
  end

  context "item is invalid" do
    scenario "item is invalid without title" do
      user = create(:user)
      user.admin!
      Category.create(name: "Briney")

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Description", with: "It's green"
      fill_in "Price", with: 4.00

      check "Briney"

      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Please enter complete information for all fields")
      expect(page).to_not have_content("Pickle Successfully Created!")
      expect(page).to_not have_content("Double Dill")
      expect(page).to_not have_content("It's green")
      expect(page).to_not have_content("$4.00")
      expect(page).to_not have_xpath("//*[@id='pickle_2']/img")
    end

    scenario "item is invalid without description" do
      user = create(:user)
      user.admin!
      Category.create(name: "Briney")

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Title", with: "Double Dill"
      fill_in "Price", with: 4.00

      check "Briney"

      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Please enter complete information for all fields")
      expect(page).to_not have_content("Pickle Successfully Created!")
      expect(page).to_not have_content("Double Dill")
      expect(page).to_not have_content("It's green")
      expect(page).to_not have_content("$4.00")
      expect(page).to_not have_xpath("//*[@id='pickle_2']/img")
    end

    scenario "item is invalid without price" do
      user = create(:user)
      user.admin!
      Category.create(name: "Briney")

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Title", with: "Double Dill"
      fill_in "Description", with: "It's green"

      check "Briney"

      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Please enter complete information for all fields")
      expect(page).to_not have_content("Pickle Successfully Created!")
      expect(page).to_not have_content("Double Dill")
      expect(page).to_not have_content("It's green")
      expect(page).to_not have_content("$4.00")
      expect(page).to_not have_xpath("//*[@id='pickle_2']/img")
    end

    scenario "item titles must be unique" do
      user = create(:user)
      user.admin!
      category = Category.create(name: "Briney")
      item = category.items.create(title: "Double Dill", description: "It's a pickle", price: 5.0)


      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit admin_dashboard_path
      click_on "Add New Item"

      expect(current_path).to eq(new_admin_item_path)


      fill_in "Title", with: "Double Dill"
      fill_in "Description", with: "It's green"
      fill_in "Price", with: 4.0

      check "Briney"

      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(Item.count).to eq(1)
      expect(page).to have_content("Please enter complete information for all fields")
      expect(page).to_not have_content("Pickle Successfully Created!")
      expect(page).to_not have_content("Double Dill")
      expect(page).to_not have_content("It's green")
      expect(page).to_not have_content("$4.00")
      expect(page).to_not have_xpath("//*[@id='pickle_2']/img")
    end
  end
end
