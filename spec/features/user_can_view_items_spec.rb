require 'rails_helper'

RSpec.feature "User can view many items" do
  context "there are three items" do
    scenario "user sees three items on index page" do
      item1, item2, item3 = create_list(:item, 3)

      visit items_path

      save_and_open_page
      
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
      expect(page).to have_content(item2.price)
      expect(page).to have_css("img[src*='#{item3.image_url}']")
    end
  end
end
