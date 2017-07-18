class MessagesController < InheritedResources::Base

  private

    def message_params
      params.require(:message).permit(:body, :chat_room_id)
    end
end

