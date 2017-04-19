class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_back(fallback_location: items_path)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to items_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :item_id)
  end
end
