require 'rails_helper'

RSpec.feature "Adjust Cart Quantity" do
  context "when there is an item in my cart" do
    before :each do
      @item = create(:item)

      visit items_path
      click_on "Add to Cart"
      click_on "Add to Cart"
    end
    scenario "a user can manually increase the item quantity by one" do
      visit cart_path

      expect(page).to have_content(@item.title)
      expect(page).to have_content(2)

      fill_in 'cart[quantity]', with: 3
      click_on 'Update'

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(@item.title)
      expect(page).to have_content(3)
    end
    scenario "a user can manually decrease the item quantity by one" do
      visit cart_path

      expect(page).to have_content(@item.title)
      expect(page).to have_content(2)

      fill_in 'cart[quantity]', with: 1
      click_on 'Update'

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(@item.title)
      expect(page).to have_content(1)
    end
    scenario "a user can manually increase the item quantity by ten" do
      visit cart_path

      expect(page).to have_content(@item.title)
      expect(page).to have_content(2)

      fill_in 'cart[quantity]', with: 10
      click_on 'Update'

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(@item.title)
      expect(page).to have_content(10)
    end
  end

end
