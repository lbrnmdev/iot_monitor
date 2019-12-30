class MqttStreamChannel < ApplicationCable::Channel
  def subscribed
    # FIXME: Have subscription/stream be based on device model id
    stream_from "mqtt_stream_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
