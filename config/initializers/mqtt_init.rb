require 'my_mqtt'

Rails.application.config.after_initialize do
  MyMqtt.create_and_receive
end
