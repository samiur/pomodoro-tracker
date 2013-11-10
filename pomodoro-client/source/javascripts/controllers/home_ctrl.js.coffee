app.controller 'HomeCtrl', ["$scope", "$window", "User", "Session", ($scope, $window, User, Session) ->
  $scope.loggedIn = false
  $scope.remember = true
  $scope.alerts = []

  if Session.loggedIn()
    $window.location = '/dashboard.html'

  $scope.signIn = ->
    Session.signIn($scope.email, $scope.password).then ->
      console.log "Signed In!"
      $window.location = '/tomato.html'
    , ->
      $scope.alerts.push {type: 'error', msg: 'Wrong Email/Password!'}
      console.log "Wrong Email/Password!"

  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)
]
