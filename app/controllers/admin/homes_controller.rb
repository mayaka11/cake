class Admin::HomesController < ApplicationController
  def top
     @order_derail = OrderDetail.all
     @orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

  end

  private

  def home_params
    parame.require(:home).permit(:name, :amount)
  end
end