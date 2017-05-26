class AddWalletfirmToGetmoneys < ActiveRecord::Migration[5.0]
  def change
    add_column :getmoneys, :walletfirm, :string
  end
end
