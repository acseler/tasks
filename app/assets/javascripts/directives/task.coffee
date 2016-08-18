'use strict'

@todoList.directive 'taskTemplate', ->
  scope: { task: '=' }
  templateUrl: '_task.html'
  controller: 'TaskCtrl'
