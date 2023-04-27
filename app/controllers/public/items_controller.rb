class Public::ItemsController < ApplicationController
  def index
   @item = Item.new
   @items = Item.all
  end

  def create
    binding.pry
    @item = Item.new(item_params)
    @item.item_id = current_item.id
    @item.save
    redirect_to cart_items_path
  end


    ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end


  def show
   @item = Item.find(params[:id])
   @cart_item =CartItem
  end

private

def item_params
  params.require(:item).permit(:name, :introduction, :price)
end
end
