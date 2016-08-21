'use strict'

@todoList.directive 'taskTemplate', ->
  restrict: 'C'
  scope: { task: '=' }
  templateUrl: '_task.html'
  controller: 'TaskCtrl'
