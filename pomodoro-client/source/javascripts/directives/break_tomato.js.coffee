app.directive 'breakTomato', ->
  restrict: "A"
  templateUrl: '/templates/breakTomato.html'
  link: (scope, elem, attrs) ->
  scope:
    tomato: "="
  controller: ($scope, $element, $attrs, $timeout) ->
    $scope.addTask = () ->
      $scope.tomato.addTask($scope.task)
      $scope.task = ""
