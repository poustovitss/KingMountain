class AddWalletToGetmoneys < ActiveRecord::Migration[5.0]
  def change
    add_column :getmoneys, :wallet, :float
  end
end
