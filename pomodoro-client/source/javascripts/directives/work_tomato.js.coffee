app.directive 'workTomato', ->
  restrict: "A"
  templateUrl: '/templates/workTomato.html'
  link: (scope, elem, attrs) ->
    checkboxes = angular.element('input[type="checkbox"]')
    checkboxes.each ->
      @checkbox()
  scope:
    tomato: "="
  controller: ($scope, $element, $attrs, $timeout) ->
    $scope.addTask = () ->
      $scope.tomato.addTask($scope.task)
      $scope.task = ""
