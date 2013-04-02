//= require angular/angular
//= require conversations

var ws = new WebSocket("ws://localhost:8888/realtime/chat");
ws.onopen = function() {
  ws.send("Hello, world");
};
ws.onmessage = function (evt) {
  alert(evt.data);
};