class CreateCommonChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :common_chat_messages do |t|
      t.references :user, index: true, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
