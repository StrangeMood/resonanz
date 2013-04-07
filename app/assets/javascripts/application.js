//= require jquery/jquery
//= require angular/angular
//= require angular-cookies/angular-cookies

var app = angular.module('resonanz', ['ngCookies']);

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
