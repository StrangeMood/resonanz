//= require conversations_list
//= require height_corrector
//= require autogrow-textarea/jquery.autogrowtextarea

function ConversationCtrl($scope) {
  $scope.disconnected = true

  $scope.message = ''

  $('.conversation .messages').on('scroll', function(e) {
    if (this.scrollHeight - this.scrollTop === this.clientHeight) {
      window.location.hash = 'follow'
    } else {
      window.location.hash = ''
    }
  })

  function connect() {
    var ws = new WebSocket('ws://'+window.location.host.replace(/:\d+/, '')+':8888/conversations/' + $scope.conversation.slug)

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

  $scope.isMine = function(message) {
    if (message.author.id == $scope.currentUser.id) return 'mine'
  }

  $scope.messageType = function(message, previous) {
    // merge messages from one author
    if (previous) {
      var before = moment(previous.created_at),
        after = moment(message.created_at)

      if (before.dayOfYear() != after.dayOfYear()) return 'separated'

      if (message.author.id == previous.author.id) return 'merged'
    } else {
      return 'separated'
    }
  }

  $scope.daySeparator = function(message, previous) {
    // separate messages written in different days
    if (previous) {
      var before = moment(previous.created_at),
        after = moment(message.created_at)

      if (before.dayOfYear() != after.dayOfYear()) {
        return message.created_at
      }
    } else {
      return message.created_at
    }
  }

  $scope.addMessage = function() {
    if ($scope.message.text) {
      $scope._ws.send(JSON.stringify({text: $scope.message.text}))
      $scope.message.text = ''
    }
  }

  // postpone connection establishment while initialisation finished
  setTimeout(connect, 0)
}