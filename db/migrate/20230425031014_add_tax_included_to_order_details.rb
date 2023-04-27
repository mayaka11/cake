class AddTaxIncludedToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :tax_included, :integer
  end
end
