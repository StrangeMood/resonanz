function ConversationCtrl($scope, $http) {
  $scope.disconnected = true

  function connect() {
    var ws = new WebSocket('ws://localhost:8888/conversations/' + $scope.conversation.slug)

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
        setTimeout(connect, 5000)
      })
    }

    ws.onmessage = function(e) {
      $scope.$apply(function() {
        $scope.messages.push(JSON.parse(e.data))
        console.log('MESSAGE: ', e.data)
      })
    }

    $scope._ws = ws
  }

  $scope.addMessage = function() {
    $scope._ws.send(JSON.stringify({text: $scope.message.text}))
    $scope.message.text = ''
  }

  // postpone connection establishment while initialisation finished
  setTimeout(connect, 0)
}