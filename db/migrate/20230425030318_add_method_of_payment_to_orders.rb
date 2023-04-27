class AddMethodOfPaymentToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :method_of_payment, :integer
  end
end
