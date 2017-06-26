class CreatePayeers < ActiveRecord::Migration[5.0]
  def change
    create_table :payeers do |t|
      t.string :currency
      t.text :description
      t.integer :total
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
