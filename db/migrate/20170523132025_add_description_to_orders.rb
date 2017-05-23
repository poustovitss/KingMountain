class AddDescriptionToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :description, :text
  end
end
