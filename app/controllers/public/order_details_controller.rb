class Public::OrderDetailsController < ApplicationController


private

  def order_detail_params
    params.require(:order_derail).permit(:item_id, :order_id, :tax_included, :amount, :making_status)
  end



end
