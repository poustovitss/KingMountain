class AddWhichToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :which, :string
  end
end
