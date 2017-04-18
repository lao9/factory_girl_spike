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
      flash.now[:warning] = "Please enter complete information for all fields"
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item Updated!"
      redirect_to admin_items_path
    else
      flash.now[:warning] = "Please fill out all fields"
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image_url, :category_ids => [])
  end

end
