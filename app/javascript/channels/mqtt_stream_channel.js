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
    var info = data.content.split('=>');

    // FIXME: Dirty dirty hack. Rather have subscription be based on model od ie params
    //        Fix in actioncable
    if (info[1] === document.getElementById("device_name").textContent.trim()) {
      if (info[0] === "status") {
        document.getElementById("device_status").textContent = info[2] + " on " + info[3];
        if ((info[2] === "online") || (info[2] === "Online")) {
          document.getElementById("device_name").parentElement.classList.add('green');
        } else {
          document.getElementById("device_name").parentElement.classList.remove('green');
        }
      } else if (info[0] === "temperature") {
        var reading_row = document.createElement('tr');
        var reading_time = document.createElement('td');
        reading_time.textContent = info[3];
        var reading_value = document.createElement('td');
        reading_value.className = "right aligned";
        reading_value.textContent = info[2];
        var reading_unit = document.createElement('td');
        reading_unit.textContent = "Celsius";
        reading_row.appendChild(reading_time);
        reading_row.appendChild(reading_value);
        reading_row.appendChild(reading_unit);
        var reading_table_body = document.getElementById("reading_table_body");
        if (reading_table_body.childElementCount > 4) {
          reading_table_body.removeChild(reading_table_body.lastElementChild);
        }
        reading_table_body.insertBefore(reading_row, reading_table_body.firstElementChild);

        var chart_pair = [new Date(info[3]), parseInt(info[2])];
        var temp_chart = Chartkick.charts["temp-chart"];
        var chart_data = temp_chart.getData();
        (chart_data[0]["data"]).push(chart_pair);
        temp_chart.updateData(chart_data);
      } else {

      }
    }

  }
});
