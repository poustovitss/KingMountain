class ChatRoom < ApplicationRecord
	has_many :messages, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :users, through: :subscriptions

end
