app.directive 'ngCheckbox', ->
  restrict: "C"
  require: 'ngModel'
  link: (scope, elem, attrs, ctrl) ->
    $(elem).checkbox()
    scope.$watch attrs.ngModel, ->
      $(elem).checkbox "checked", attrs.ngModel
    elem.on 'toggle', ->
      scope.$apply () ->
        scope.$eval "#{attrs.ngModel} = #{attrs.ngModel} ? false : true"
