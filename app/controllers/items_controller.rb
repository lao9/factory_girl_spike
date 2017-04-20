class ItemsController < ApplicationController

  def index
    @items = Item.where(retired: false)
  end

  def show
    @item = Item.find(params[:id])
  end

end
