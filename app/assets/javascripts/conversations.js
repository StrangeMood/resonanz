function ConversationCtrl($scope, $http) {
  $scope.addMessage = function() {
    var newMessage = {text: $scope.message.text, author: $scope.currentUser, delivered: false}

    $http({method: 'POST', url: $scope.createUrl, data: {message: newMessage}}).
      success(function(data, status, headers, config) {
        newMessage.delivered = true
      })

    $scope.messages.push(newMessage)
    $scope.message.text = ''
  }
}