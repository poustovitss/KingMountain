class CreateUnreadMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :unread_messages do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
