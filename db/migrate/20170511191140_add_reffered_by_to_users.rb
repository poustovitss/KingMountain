class AddRefferedByToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reffered_by, :integer
  end
end
