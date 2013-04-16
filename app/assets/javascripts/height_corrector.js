$(function() {
  function correctHeight() {
    var windowHeight = $(window).height()
    var headerHeight = $('body header').outerHeight()
    var formHeight = $('section.conversation form').outerHeight()

    $('#main>nav').height(windowHeight - headerHeight)

    var messagesHeight = windowHeight - headerHeight - formHeight
    if (messagesHeight < 200) {
      messagesHeight = 200
    }

    $('.conversation .messages').height(messagesHeight)
  }

  $(window).on('resize', correctHeight)
  correctHeight()
})