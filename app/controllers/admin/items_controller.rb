class Admin::ItemsController < Admin::BaseController


  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      flash[:success] = "Pickle Successfully Created!"
      redirect_to @item
    else
      flash.now[:failure] = "Please enter complete information for all fields"
      render :new
    end
  end

  def index
    @items = Item.all
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image_url, :category_ids => [])
  end


end
