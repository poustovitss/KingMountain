class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user
  has_many :unread_messages, dependent: :destroy
end
