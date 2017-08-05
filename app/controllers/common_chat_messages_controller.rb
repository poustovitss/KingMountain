class CommonChatMessagesController < ApplicationController

  def create
    @message = CommonChatMessage.new(message_params)
    @message.user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.html { redirect_to chats_path, notice: 'сообщение успешно сохранен.' }
        format.js
      else
        format.html { redirect_to chats_path, notice: 'сообщение не сохранено.' }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:common_chat_message).permit(:content)
  end

end
