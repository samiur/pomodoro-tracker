app.directive 'ngRadio', ->
  restrict: "C"
  require: 'ngModel'
  link: (scope, elem, attrs, ctrl) ->
    $(elem).radio()
    scope.$watch attrs.ngModel, ->
      $(elem).radio "radio", attrs.ngModel
    elem.on 'toggle', (event) ->
      console.log event
      scope.$apply ->
        scope.$eval "#{attrs.ngModel} = #{event.target.value}"
