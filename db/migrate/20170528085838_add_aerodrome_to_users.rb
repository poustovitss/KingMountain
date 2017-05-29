class AddAerodromeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :aerodrome, :boolean, default: false
  end
end
