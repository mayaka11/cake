class Admin::OrderDetailsController < ApplicationController
  def update
  end

private

 def order_details_params
   params.require(:order_detail).permit(:item_id, :order_id, :tax_included, :amount, :making_status)
 end

end
