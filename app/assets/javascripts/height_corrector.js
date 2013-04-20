$(document).on('ready page:load', function() {
  function correctHeight() {
    var windowHeight = $(window).height()
    var headerHeight = $('body header').outerHeight()
    var formHeight = $('section.conversation form').outerHeight()

    var messagesContainer = $('.conversation .messages')

    $('#main>nav').height(windowHeight - headerHeight)

    var messagesHeight = windowHeight - headerHeight - formHeight
    if (messagesHeight < 200) {
      messagesHeight = 200
    }

    messagesContainer.height(messagesHeight)

    if (window.location.hash === '#follow') {
      messagesContainer.scrollTop(1000000)
    }
  }

  $('.text-area textarea')
    .on('keyup', function() { setTimeout(correctHeight, 0) })
    .autoGrow()

  $(window).on('resize', correctHeight)
  correctHeight()
})