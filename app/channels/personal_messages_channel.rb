class PersonalMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "personal_messages_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
