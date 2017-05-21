class AddConductorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :conductor, :boolean, default: false
  end
end
