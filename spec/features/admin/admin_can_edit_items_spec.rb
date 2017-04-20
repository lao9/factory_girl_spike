require "rails_helper"


RSpec.feature "Admin can edit items" do
  context "Item is valid" do
    scenario "Admin can edit title, description, price, and image_url" do
      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      briney = Category.create(name: "Briney")
      delicioso = Category.create(name: "Delicious")
      item = briney.items.create(title: "Pickle", description: "It's green", price: 4.00, image_url: "http://images.wisegeek.com/cornichons-in-a-jar.jpg")

      visit admin_items_path
      click_on "Edit"

      expect(current_path).to eq("/admin/items/#{item.id}/edit")

      fill_in "Title", with: "Jalapeños con conejitos"
      fill_in "Description", with: "crujiente y delicioso"
      fill_in "Price", with: 8.00
      attach_file "Image", "spec/fixtures/capybara.jpg"

      check "Delicious"

      click_on "Update Item"

      expect(Item.count).to eq(1)
      expect(item.categories.last.name).to eq("Delicious")
      expect(page).to have_content("Item Updated!")
      expect(page).to have_content("Jalapeños con conejitos")
      expect(page).to have_content("crujiente y delicioso")
      expect(page).to have_content("$8.00")
    end
  end

  context "Item is invalid" do
    scenario "Admin cannot edit without title" do
      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      briney = Category.create(name: "Briney")
      briney = Category.create(name: "Delicious")
      item = briney.items.create(title: "Pickle", description: "It's green", price: 4.00, image_url: "http://images.wisegeek.com/cornichons-in-a-jar.jpg")

      visit admin_items_path
      click_on "Edit"

      expect(current_path).to eq("/admin/items/#{item.id}/edit")

      fill_in "Title", with: ""
      fill_in "Description", with: "crujiente y delicioso"
      fill_in "Price", with: 8.00
      attach_file "Image", "spec/fixtures/capybara.jpg"


      click_on "Update Item"

      expect(Item.count).to eq(1)
      expect(page).to_not have_content("Item Updated!")
      expect(page).to_not have_content("Jalapeños con conejitos")
      expect(page).to_not have_content("crujiente y delicioso")
      expect(page).to_not have_content("$8.00")
    end

    scenario "Admin cannot edit without description" do
      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      briney = Category.create(name: "Briney")
      briney = Category.create(name: "Delicious")
      item = briney.items.create(title: "Pickle", description: "It's green", price: 4.00, image_url: "http://images.wisegeek.com/cornichons-in-a-jar.jpg")

      visit admin_items_path
      click_on "Edit"

      expect(current_path).to eq("/admin/items/#{item.id}/edit")

      fill_in "Title", with: "Jalapeños con conejitos"
      fill_in "Description", with: ""
      fill_in "Price", with: 8.00
      attach_file "Image", "spec/fixtures/capybara.jpg"

      check "Delicious"

      click_on "Update Item"

      expect(Item.count).to eq(1)
      expect(page).to_not have_content("Item Updated!")
      expect(page).to_not have_content("crujiente y delicioso")
      expect(page).to_not have_content("$8.00")
    end

    scenario "Admin cannot edit without price" do
      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      briney = Category.create(name: "Briney")
      briney = Category.create(name: "Delicious")
      item = briney.items.create(title: "Pickle", description: "It's green", price: 4.00, image_url: "http://images.wisegeek.com/cornichons-in-a-jar.jpg")

      visit admin_items_path
      click_on "Edit"

      expect(current_path).to eq("/admin/items/#{item.id}/edit")

      fill_in "Title", with: "Jalapeños con conejitos"
      fill_in "Description", with: "crujiente y delicioso"
      fill_in "Price", with: ""
      attach_file "Image", "spec/fixtures/capybara.jpg"

      check "Delicious"

      click_on "Update Item"

      expect(Item.count).to eq(1)
      expect(page).to_not have_content("Item Updated!")
      expect(page).to_not have_content("crujiente y delicioso")
      expect(page).to_not have_content("$8.00")
    end
  end
end
