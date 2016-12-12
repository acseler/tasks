@todoList.directive 'datetimepickerNeutralTimezone', ->
  restrict: 'A'
  priority: 1
  require: 'ngModel'
  link: (scope, element, attrs, ctrl) ->
    ctrl.$parsers.push( (value) ->
      date = new Date(value.getTime() - (60000 * value.getTimezoneOffset()))
    )