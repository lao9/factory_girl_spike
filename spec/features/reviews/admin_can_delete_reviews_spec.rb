require "rails_helper"


RSpec.feature "admin can see reviews" do\
  context "for an existing review" do
    scenario "admin can delete the review" do
      review = create(:review)

      user = create(:user)
      user.admin!

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)


      visit item_path(review.item)

      expect(page).to have_content("Reviews: 1")
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.body)
      expect(page).to have_content(review.user.first_name)
      expect(page).to have_content("Rating: #{review.rating}")
      expect(page).to have_button("Delete Review")

      click_on "Delete Review"

      visit item_path(review.item)

      expect(page).to_not have_content("Reviews: 1")
      expect(page).to_not have_content(review.title)
      expect(page).to_not have_content(review.body)
      expect(page).to_not have_content(review.user.first_name)
      expect(page).to_not have_content("Rating: #{review.rating}")
    end
  end
end

# As an admin
#
# context: an item already has a single review
#
# When I visit an item's show page
#
# I should see the review, the reviewer's full name, the rating (out of 5), and the date of the review
#
# And I click delete
#
# Then I should not see that review anymore
#
# And I should see "Reviews (0):"
#
