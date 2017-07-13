class AddBonusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bonus, :boolean, default: :false
  end
end
