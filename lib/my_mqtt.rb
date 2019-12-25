module MyMqtt

  def self.create_and_receive
    Thread.new do
      # TODO: Handle disconnects
      MQTT::Client.connect('localhost') do |c|
        Rails.logger.info("Starting mqtt connection")
        puts "Starting mqtt connection"
        c.subscribe('/monitor/status', '/board/temp', '/board/button') # subscribe to topics
        c.get do |topic, message|
          Rails.logger.info("Topic: #{topic}, Message: #{message}")
          "Topic: #{topic}, Message: #{message}"
        end
      end
    end
  end

end
