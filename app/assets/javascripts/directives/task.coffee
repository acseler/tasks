'use strict'

@todoList.directive 'taskTemplate', ->
  restrict: 'C'
  replace: true
  scope: {
    task: '='
    updateTask: '&'
    deleteTask: '&'
  }
  templateUrl: '_task.html'
  controller: 'TaskCtrl'
