function ConversationCtrl($scope, $http) {

  var ws = new WebSocket('ws://localhost:8888' + window.location.pathname)

  ws.onmessage = function(evt) {
    $scope.$apply(function() {
      $scope.messages.push(JSON.parse(evt.data))
    })
  };

  $scope.addMessage = function() {
    ws.send(JSON.stringify({text: $scope.message.text}))
    $scope.message.text = ''
  }
}