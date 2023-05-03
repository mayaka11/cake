class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!
  def top
    @orders = Order.all.page(params[:page])
    @order_details = OrderDetail.all.page(params[:page])
  end

  private

  def home_params
    parame.require(:home).permit(:name, :amount)
  end

end