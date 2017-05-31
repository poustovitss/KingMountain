class CreateSystemfinances < ActiveRecord::Migration[5.0]
  def change
    create_table :systemfinances do |t|
      t.string :name
      t.float :summa

      t.timestamps
    end
  end
end
