class AddActiveToBanks < ActiveRecord::Migration[5.0]
  def change
    add_column :banks, :active, :boolean, default: true
  end
end
