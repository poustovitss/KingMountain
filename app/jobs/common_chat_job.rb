class CommonChatJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'common_channel', {
        message: CommonChatMessagesController.render(
            partial: 'common_chat_message',
            locals: { common_chat_message: message }
        ).squish
    }
  end
end
