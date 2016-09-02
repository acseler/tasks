'use strict'

@todoList.directive 'taskTemplate', ->
  restrict: 'C'
  replace: true
  scope: {
    task: '='
    initTasks: '&'
  }
  templateUrl: '_task.html'
  controller: 'TaskCtrl'
