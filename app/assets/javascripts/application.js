//= require fastclick/lib/fastclick

//= require moment/moment
//= require moment/min/lang/ru

//= require jquery/jquery
//= require jquery.cookie/jquery.cookie

var app = angular.module('resonanz', []);

app.directive('onKeyup', function() {
  return function(scope, elm, attrs) {
    //Evaluate the variable that was passed
    //In this case we're just passing a variable that points
    //to a function we'll call each keyup
    var keyupFn = scope.$eval(attrs.onKeyup)
    elm.bind('keyup', function(evt) {
      //$apply makes sure that angular knows
      //we're changing something
      scope.$apply(function() {
        keyupFn.call(scope, evt)
      })
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

$(function() {
  window.currentLocale = $('meta[name=language]').attr('content')
  moment.lang(window.currentLocale)
})