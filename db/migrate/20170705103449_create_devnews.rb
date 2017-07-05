class CreateDevnews < ActiveRecord::Migration[5.0]
  def change
    create_table :devnews do |t|
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
