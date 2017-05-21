class AddCarrierToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :carrier, :boolean, default: false
  end
end
