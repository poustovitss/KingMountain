class ChatRoomsController < InheritedResources::Base

  private

    def chat_room_params
      params.require(:chat_room).permit(:title)
    end
end

