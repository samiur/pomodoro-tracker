app.controller 'NavigationCtrl', ["$scope", "$rootScope", "$window", "User", "Session", ($scope, $rootScope, $window, User, Session) ->
  $scope.loggedIn = false
  if Session.loggedIn()
    Session.currentUser().then (response) ->
      $scope.loggedIn = true
      #$scope.currentUser = response
      $rootScope.currentUser = response
      $rootScope.$broadcast 'currentUserReady'
    , (response, status) ->
      console.log "Failed to use AuthToken, clearing cookies"
      $window.location = '/home.html'

  $scope.signOut = ->
    Session.signOut().then ->
      console.log "Signed Out!"
      $window.location = '/home.html'
]
