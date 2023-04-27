class AddPostageToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :postage, :integer
  end
end
