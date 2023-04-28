class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!


  def index
   @customer = Customer.new
   @customers = Customer.all
  end

 def show
   @customer = Customer.find(params[:id])
 end

 def edit
   @customer = Customer.find(params[:id])
 end

 def update
  @customer = current_customer
  if @customer.update(customer_params)
   redirect_to customer_path
  else
   render :edit
  end
 end

 def quit
  @customer = current_customer
 end

 def withdrawal
  @customer = current_customer
  @customer.update(is_deleted: true)
  reset_session
  redirect_to root_path
 end


private

 def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
 end

end