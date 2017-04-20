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

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(review.user)

      visit item_path(review.item)

      fill_in "review[body]", with: "Filled in review"
      fill_in "Title", with: "Filled in title"
      select(5, from: "Rating")
      click_on "Submit Review"

      visit item_path(review.item)

      expect(page).to have_content("Reviews: 2")
      expect(page).to have_content("Filled in review")
      expect(page).to have_content("Filled in title")
      expect(page).to have_content(review.user.first_name)
      expect(page).to have_content("Rating: 5")
    end
  end
end
