class Public::OrdersController < ApplicationController


  def index
    @orders = current_customer
  end


  def new
    @order = Order.new
    @customer = current_customer
  end

  def create

  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end




  def completion
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :name)
  end

end