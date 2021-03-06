//= require turbolinks
//= require fastclick/lib/fastclick

//= require moment/moment
//= require moment/min/lang/ru

//= require jquery/jquery
//= require jquery.cookie/jquery.cookie

//= require showdown/src/showdown

var app = angular.module('resonanz', []);

app.directive('onEnterKeypress', function() {
  return function(scope, elm, attrs) {
    elm.bind('keydown', function(evt) {
      evt = jQuery.event.fix(evt)
      if (evt.which == 13 && !(evt.metaKey || evt.ctrlKey || evt.altKey)) {
        evt.preventDefault()
        scope.$apply(attrs.onEnterKeypress)
      }
    })
  }
})

app.filter('moment', function() {
    return function(date, type) {
      if (!date) return

      var date = moment(date)

      if (date.isValid()) {
        switch (type) {
          case 'day':
            // this week
            if (date.week() == moment().week()) {
              return date.format('dddd')
            } else {
              return date.format('DD MMM')
            }
          case 'time':
            return date.format('LT')
          default:
            return date.format(type)
        }
      }
    }
  }
)

app.filter('markdown', function() {
    var converter = new Showdown.converter()

    return function(text) {
      if (!text) return

      return converter.makeHtml(text)
    }
  }
)

$(document).on('ready page:load', function() {
  angular.bootstrap(document, ['resonanz'])

  window.currentLocale = $('meta[name=language]').attr('content')
  moment.lang(window.currentLocale)
})
