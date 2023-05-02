class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面
    @order = Order.new
    @addresses = current_customer.addresses.all
    @customer = current_customer
  end


  def log #注文情報確認画面
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
     if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

     elsif params[:order][:address_option] == "1"
       ship = Address.find(params[:order][:customer_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

     elsif params[:order][:address_option] == "2"
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @order.postal_code = params[:order][:postal_code]
      @ship_city.customer_id = current_customer.id
      if @ship_city.save
      @order.name = @address.name
      @order.address = @address.address
      @order.postal_code = @address.postal_code
      else
        render 'new'
      end
      @order.customer_id = current_customer.id
     end
  end


  def create #注文情報保存
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
      current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
        @order_detail = OrderDetail.new(order_id: @order.id)  #初期化宣言
        @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
        @order_detail.amount = cart_item.amount #商品の個数を注文商品の個数に代入
        @order_detail.tax_included = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
        @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
        @order_detail.save #注文商品を保存
      end
       current_customer.cart_items.destroy_all #カートの中身を削除
       redirect_to orders_completion_path
  end


  def completion #注文完了画面
  end

  def index  #注文情報履歴一覧
    @orders = current_customer.orders
  end

  def show #注文情報詳細
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end





  private

  def order_params
    params.require(:order).permit(:postal_code, :name, :address, :method_of_payment, :postage, :customer_id, :billing_amount, :status)
  end


end