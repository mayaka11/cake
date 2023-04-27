class Public::AddressesController < ApplicationController
  def index
    @addresses = Adress.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    order = Order.new(order_params)
    order.save
    redirect_to orders_path
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to address_path(address.id)
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to address_path(address.id)
  end


private

 def address_params
   params.require(:address).permit(:customer_id, :name, :postal_code, :address)
 end
end
