'use strict'

@todoList.directive 'taskTemplate', ->
  restrict: 'C'
  replace: true
  scope: { task: '=' }
  templateUrl: '_task.html'
  controller: 'TaskCtrl'
