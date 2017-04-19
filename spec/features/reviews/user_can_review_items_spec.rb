require "rails_helper"


RSpec.feature "User can see reviews" do\
  context "for an existing review" do
    scenario "user can see the review" do
      review = create(:review)

      visit item_path(review.item)

      expect(page).to have_content("Reviews: 1")
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.body)
      expect(page).to have_content(review.user.first_name)
      expect(page).to have_content("Rating: #{review.rating}")
      expect(page).to_not have_button("Delete Review")
    end
  end
  context "user wants to review the pickles" do
    scenario "user fills out form and sees their review" do
      review = create(:review)
      visit item_path(review.item)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(review.user)
      fill_in "review[body]", with: "Filled in review"
      fill_in "Title", with: "Filled in title"
      select(5, from: "Rating")
      click_on "Submit Review"
    end
  end
end
# As a default user
#
# context: an item already has a single review
#
# When I visit an item's show page
#
# And I fill in my review and the rating
#
# And I click Submit
#
# I should still be on that item's show page
#
# And I should see "Reviews (2):"
#
# And I see my review at the top
#
# And I see the older review at the bottom
