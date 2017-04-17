require 'rails_helper'

RSpec.feature "User can add items to cart" do
  context "as a visitor" do
    scenario "user can add items to cart from index" do
      item = create(:item)
      visit items_path
      click_on "Add to Cart"
      expect(page).to have_content("Successfully added #{item.title} to your cart")
      click_on "View Cart"

      expect(current_path).to eq("/cart")
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_css("img[src*='#{item.image_url}']")
      expect(page).to have_content("Total Price: $#{item.price}")
      expect(page).to have_content("Total Quantity: 1")
    end

    scenario "user can add same item to cart multiple times" do
      item = create(:item)

      visit items_path

      click_on "Add to Cart"
      click_on "Add to Cart"
      click_on "Add to Cart"
      click_on "Add to Cart"

      expect(page).to have_content("Successfully added #{item.title} to your cart")

      click_on "View Cart"

      expect(current_path).to eq("/cart")

      expect(page).to have_content(item.title)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_css("img[src*='#{item.image_url}']")
      expect(page).to have_content("Total Price: $#{item.price * 4}")
      expect(page).to have_content("Total Quantity: 4")
    end
    scenario "user can add several different items to cart from index" do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      visit items_path

      within("div#pickle_#{item1.id}.pickle") do
        click_on "Add to Cart"
      end

      expect(page).to have_content("Successfully added #{item1.title} to your cart")

      within("div#pickle_#{item2.id}") do
        click_on "Add to Cart"
      end

      expect(page).to have_content("Successfully added #{item2.title} to your cart")

      within("div#pickle_#{item3.id}.pickle") do
        click_on "Add to Cart"
      end

      expect(page).to have_content("Successfully added #{item3.title} to your cart")
      click_on "View Cart"

      expect(current_path).to eq("/cart")

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.price)
      expect(page).to have_css("img[src*='#{item1.image_url}']")
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item2.price)
      expect(page).to have_css("img[src*='#{item2.image_url}']")
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item3.description)
      expect(page).to have_content(item3.price)
      expect(page).to have_css("img[src*='#{item3.image_url}']")
      expect(page).to have_content("Total Quantity: 3")
      expect(page).to have_content("Total Price: $#{Item.sum(:price)}")
    end
  end
end
