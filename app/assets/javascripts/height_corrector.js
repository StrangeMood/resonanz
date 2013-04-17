$(function() {
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

  $('.conversation textarea')
    .on('keyup', function() { setTimeout(correctHeight, 0) })
    .autoGrow()

  $(window).on('resize', correctHeight)
  correctHeight()
})