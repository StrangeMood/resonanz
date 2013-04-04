function ConversationCtrl($scope, $http) {
  $scope.disconnected = true

  var ws = new WebSocket('ws://localhost:8888' + window.location.pathname)

  ws.onopen = function(e) {
    $scope.$apply(function() {
      $scope.disconnected = false
      console.log('CONNECTED SUCCESSFULLY')
    })
  }

  ws.onclose = function(e) {
    $scope.$apply(function() {
      $scope.disconnected = true
      console.log('DISCONNECTED')
    })
  }

  ws.onmessage = function(e) {
    $scope.$apply(function() {
      $scope.messages.push(JSON.parse(e.data))
      console.log('MESSAGE: ', e.data)
    })
  }

  $scope.addMessage = function() {
    ws.send(JSON.stringify({text: $scope.message.text}))
    $scope.message.text = ''
  }
}