class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :user, foreign_key: true
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
