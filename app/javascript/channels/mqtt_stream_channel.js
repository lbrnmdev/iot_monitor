import consumer from "./consumer"

consumer.subscriptions.create("MqttStreamChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    var node = document.createElement("P");
    var textnode = document.createTextNode("new reading");
    node.appendChild(textnode);
    document.getElementById("new_reading").appendChild(node);
  }
});
