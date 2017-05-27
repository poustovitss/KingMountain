class CreateGetbalances < ActiveRecord::Migration[5.0]
  def change
    create_table :getbalances do |t|
      t.string :walletfirm
      t.string :status
      t.string :wallet
      t.text :desc
      t.float :total

      t.timestamps
    end
  end
end
