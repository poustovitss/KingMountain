class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
