class Admin::OrdersController < ApplicationController
  def show
  end

  def update
  end


  private

 def orders_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :postage, :billing_amount, :method_of_payment, :status)
 end
end
