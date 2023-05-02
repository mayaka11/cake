class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = Order_detail.find(params[:id])
    @order = @order_detail.order
    #byebug
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_details.where(make_status: "製作中").count >= 1
      @order.status = "製作中"
      @order.save
    end

     if @order.order_details.count == @order_details.where(make_status: "製作完了").count
       @order.status = "発送準備中"
       @order.save
     end
    redirect_to admin_order_path(@order_detail.order.id)
  end



private

 def order_detail_params
   params.require(:order_detail).permit(:item_id, :order_id, :tax_included, :amount, :making_status)
 end

end
