//= require conversations_list

function ConversationCtrl($scope) {
  $scope.disconnected = true

  $scope.submitOnEnter = $.cookie('submit_on_enter') == '1'

  $('.conversation .messages').on('scroll', function(e) {
    if (this.scrollHeight - this.scrollTop === this.clientHeight) {
      window.location.hash = 'follow'
    } else {
      window.location.hash = ''
    }
  })

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

      if (window.location.hash === '#follow') {
        $('.conversation .messages').scrollTop(1000000)
      }
    }

    $scope._ws = ws
  }

  $scope.addMessage = function() {
    if ($scope.message.text) {
      $scope._ws.send(JSON.stringify({text: $scope.message.text}))
      $scope.message.text = ''
    }
  }

  $scope.textAreaKeypress = function(e) {
    if (e.which == 13 && $scope.submitOnEnter) {
      $scope.addMessage()
    }
  }

  $scope.writeUserSettings = function() {
    $.cookie('submit_on_enter', ($scope.submitOnEnter ? '1' : '0'), {path: '/'})
  }

  // postpone connection establishment while initialisation finished
  setTimeout(connect, 0)
}