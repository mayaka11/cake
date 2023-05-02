class AddAmountToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :amount, :integer
  end
end
