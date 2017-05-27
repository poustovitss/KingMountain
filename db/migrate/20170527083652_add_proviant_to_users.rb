class AddProviantToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :proviant, :boolean
  end
end
