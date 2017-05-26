class CreateGetmoneys < ActiveRecord::Migration[5.0]
  def change
    create_table :getmoneys do |t|
      t.float :total
      t.text :desc
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
