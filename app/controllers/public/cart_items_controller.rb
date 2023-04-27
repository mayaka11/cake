class Public::CartItemsController < ApplicationController


  def index
      @cart_item = Cart_item.new
      @cart_items = current_customer.cart_items.all

  end

  def create
    cart_item = CartItem.new(cart_item_params)
     if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
                          #元々カート内にあるもの「item_id」
                          #今追加した　　　　　　　params[:cart_item][:item_id])
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.save
        redirect_to cart_items_path(cart_item.id)
     else
        @cart_item.save
        @cart_items = current_customer.cart_items.all
        render 'index'
     end
  end

    ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end


  def update
    cart_item = Cart_item.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_item_path(cart_item.id)
  end

  def destroy
    cart_item = Cart_item.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_item_path
  end

  def destroy_all
    cart_items = Cart_item.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end



private

 def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount, :customer_id)
 end



end
