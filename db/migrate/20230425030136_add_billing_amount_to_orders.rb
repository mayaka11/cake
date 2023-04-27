class AddBillingAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :billing_amount, :integer
  end
end
