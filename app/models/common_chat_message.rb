class CommonChatMessage < ApplicationRecord
  belongs_to :user

  after_create_commit { CommonChatJob.perform_later self }
end
