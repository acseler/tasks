'use strict'

@todoList.directive 'projectTasks', ->
  restrict: 'E'
  scope: { projectId: '=', tasks: '=' }
  templateUrl: '_tasks.html'
  controller: 'TasksCtrl'

