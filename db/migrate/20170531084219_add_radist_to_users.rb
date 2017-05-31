class AddRadistToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :radist, :boolean, default: false
  end
end
