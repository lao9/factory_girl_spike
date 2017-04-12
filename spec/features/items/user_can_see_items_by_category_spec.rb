require "rails_helper"
RSpec.describe "User can see categorized items" do
  it "when there are 2 categories with multiple items" do
    category1, category2 = create_list(:category_with_items, 2)
    item1, item2 = category1.items
    item3, item4 = category2.items
    visit("/#{category1.name}")

    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item2.description)
    expect(page).to_not have_content(item3.title)
    expect(page).to_not have_content(item4.title)
  end
end
