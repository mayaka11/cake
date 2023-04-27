class Public::OrdersController < ApplicationController
  def new  #注文情報入力画面
    @order = Order.new
    @addresses = current_customer
  end

  def log  #注文情報入力確認画面
     @order = Order.new(order_params)
# new 画面から渡ってきたデータを @order に入れます
  if params[:order][:address_number] == "1"
# view で定義している address_number が"1"だったときにこの処理を実行します
# form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
# この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
    @order.name = current_customer.name # @order の各カラムに必要なものを入れます
    @order.address = current_customer.customer_address
  elsif params[:order][:address_number] == "2"
# view で定義している address_number が"2"だったときにこの処理を実行します
    if Address.exists?(name: params[:order][:registered])
# registered は viwe で定義しています
      @order.name = Address.find(params[:order][:registered]).name
      @order.address = Address.find(params[:order][:registered]).address
    else
      render :new
# 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
    end
  elsif params[:order][:address_number] == "3"
# view で定義している address_number が"3"だったときにこの処理を実行します
    address_new = current_customer.addresses.new(address_params)
    if address_new.save # 確定前(確認画面)で save してしまうことになりますが...
    else
      render :new
# ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
    end
  else
    redirect_to 遷移したいページ # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
  end
  @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
# 合計金額を出す処理です sum_price はモデルで定義したメソッドです
  end

  def completion

  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.order.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity

        # 購入が完了したらカート情報は削除するのでこちらに保存
        order_item.order_price = cart.item.price
        # カート情報を削除するので item との紐付けが切れる前に保存
        order_item.save
    end
      redirect_to orders_path
      cart_items.destroy_all
     # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
       @order = Order.new(order_params)
       render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end


private

 def order_params
   params.require(:order).permit(:last_name, :first_name, :postal_code, :address)
 end


 def address_params
  params.require(:order).permit(:name, :address)
 end
end
