class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:category_name])
    @items = @category.items.where(retired: false)
  end
end
