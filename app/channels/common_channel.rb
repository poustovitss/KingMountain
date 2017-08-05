class CommonChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'common_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
