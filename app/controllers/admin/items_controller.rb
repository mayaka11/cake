class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

def new
 @item = Item.new
end

def create
 @item = Item.new(item_params)
 if @item.save
    redirect_to admin_item_path(@item.id)
 else
    @items = Item.all
    render :index
 end
end

def index
  @item = Item.new
  @items = Item.all
end

def show
  @item = Item.find(params[:id])
end

def edit
  @item = Item.find(params[:id])
end

def update
  @item = Item.find(params[:id])
  @item.update(item_params)
  redirect_to admin_items_path(@item.id)
end


private

def item_params
  params.require(:item).permit(:name, :introduction, :price, :image)
end

end
