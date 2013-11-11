class Timer
  start: () =>
    @ticking = true

  stop: () =>
    @ticking = false

  onFinished: () =>
    @stop()
    @finished = true

  tick: () =>
    if @ticking
      if @sec is 0
        @onFinished()
      else
        @sec--
      @timeout = @timeoutFn(@tick, 1000)

  percentComplete: () ->
    @sec*100/@startSec

  constructor: (@startSec, @timeoutFn) ->
    @sec = startSec
    @timeout = timeoutFn(@tick, 1000)
    @ticking = false
    @finished = false


ModalInstanceCtrl = ($scope, $modalInstance, title, text) ->
  $scope.title = title
  $scope.text = text

  $scope.ok = ->
    $modalInstance.close('ok')

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

app.controller 'TomatoCtrl', ["$scope", "$timeout", "$modal", "$cookieStore",
"$window", "timerService", "Tomato", "User", "Session",
($scope, $timeout, $modal, $cookieStore, $window, timerService, Tomato, User, Session) ->
  $scope.breakTime = 5
  $scope.planTime = 5
  $scope.workTime = 20
  $scope.loaded = false

  unless Session.loggedIn()
    $window.location = '/home.html'

  $scope.tomatoInProgress = false

  $scope.$on 'currentUserReady', ->
    console.log "I think I'm logged in!"
    $scope.loaded = true

  $scope.startTomato = ->
    $scope.tomato = new Tomato($scope.breakTime*60,$scope.planTime*60,$scope.workTime*60, $scope.currentUser.id)
    $scope.tomato.start()
    $scope.tomatoInProgress = true
    $scope.$watch "tomato.started", (newVal, oldVal) ->
      unless newVal
        if $scope.tomato.completed
          $scope.tomatoInProgress = false
          $scope.tomato.create().then ->
            $window.location = '/dashboard.html'
          , ->
            console.log "Tomato add failed"
        else
          console.log "Timer finished"
          current_mode = $scope.tomato.previousStage()
          nextMode = $scope.tomato.newStage()
          modalInstance = $modal.open
            templateUrl: '/templates/modalInstance.html'
            controller: ModalInstanceCtrl
            resolve:
              title: -> "#{current_mode.title} done! Up next: #{nextMode.title}"
              text: -> nextMode.text
          modalInstance.result.then(
            ((result) ->
              console.log result
              $scope.tomato.nextStage()),
            ((result) ->
              console.log result))

  $scope.cancelTomato = (tomato) ->
    tomato.stop()
    $scope.tomatoInProgress = false
    tomato.create().then ->
      $window.location = '/dashboard.html'
    , ->
      console.log "Tomato add failed"
]
