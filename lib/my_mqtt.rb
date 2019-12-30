module MyMqtt
  class << self

    def create_and_receive
      Thread.new do
        # TODO: Handle disconnects
        MQTT::Client.connect('localhost') do |c|
          Rails.logger.info("Starting mqtt connection")
          puts "Starting mqtt connection"
          c.subscribe('/monitor/status', '/board/temp', '/board/button') # subscribe to topics
          c.get do |topic, message|
            received_time = DateTime.now
            Rails.logger.info("Topic: #{topic}, Message: #{message}, DateTime: #{received_time}")
            puts "Topic: #{topic}, Message: #{message}, DateTime: #{received_time}"
            update_monitor(topic, parse_message(message), received_time)
          end
        end
      end
    end

    private

      # TODO: after improving the message format being transmitted by device,
      #       modify this accordingly
      # TODO: handle messages that don't match expected format
      # Return array containing device name and value transmitted
      def parse_message message
        message.split("=>").map { |i| i.strip  }
      end

      # FIXME: i'm hella tired. whadya want...
      # FIXME: Broadcast solely to device's model object
      # FIXME: Refactor is not a heavy enough word...
      def update_monitor topic, name_value_pair, received_time
        name = name_value_pair[0]
        value = name_value_pair[1]
        device = Device.find_by(name: name)
        msg_type = ""

        if topic=="/monitor/status"
          msg_type = "status"
          if device
            device.update(status: value, status_time: received_time)
            ActionCable.server.broadcast 'mqtt_stream_channel', content: "#{msg_type}=>#{name}=>#{value}=>#{received_time.to_s(:rfc822)}"
          else
            new_device = Device.create(name: name, status: value, status_time: received_time)
            ActionCable.server.broadcast 'mqtt_stream_channel', content: "#{msg_type}=>#{name}=>#{value}=>#{received_time.to_s(:rfc822)}"
          end
        elsif topic=="/board/temp"
          msg_type = "temperature"
          if device
            device.temp_readings.create(value: value, unit: 'Celsius', received_time: received_time)
            ActionCable.server.broadcast 'mqtt_stream_channel', content: "#{msg_type}=>#{name}=>#{BigDecimal(value)}=>#{received_time.to_s(:rfc822)}"
          else
            new_device = Device.create(name: name)
            new_device.temp_readings.create(value: value, unit: 'Celsius', received_time: received_time)
            ActionCable.server.broadcast 'mqtt_stream_channel', content: "#{msg_type}=>#{name}=>#{BigDecimal(value)}=>#{received_time.to_s(:rfc822)}"
          end
        else
          Rails.logger.error "Unable to match topic in MyMqtt"
        end
      end

  end
end
