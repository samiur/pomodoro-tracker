app.directive 'ngTimer', ["$timeout", ($timeout) ->
  restrict: "A"
  template: "<div class='timer'>{{toMin(time)}} minutes and {{toSec(time)}} seconds</div>"
  link: (scope, elem, attrs) ->
    scope.toMin = (timer) ->
      Math.floor(timer.sec/60)
    scope.toSec = (timer) ->
      timer.sec%60
  scope:
    time: "="
  controller: ($scope, $element, $attrs, $timeout) ->
    # $scope.isTiming = false
    # console.log $attrs
    # $scope.currentTime = $scope.time
    # $scope.stop = ->
    #   $scope.isTiming = false
    # $scope.start = ->
    #   $scope.isTiming = true
    # $scope.onTimeout = ->
    #   if $scope.isTiming
    #     if $scope.currentTime.sec is 0
    #       if $scope.currentTime.min is 0
    #         $scope.stop()
    #       else
    #         $scope.currentTime.min--
    #         $scope.currentTime.sec = 59
    #     else
    #       $scope.time.sec--
    #     mytimeout = $timeout($scope.onTimeout,1000)

    # $scope.start()
    # mytimeout = $timeout($scope.onTimeout,1000)
]
