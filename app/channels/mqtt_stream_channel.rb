class MqttStreamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "mqtt_stream_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
