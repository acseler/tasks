'use strict'

@todoList.directive 'projectTasks', ->
  restrict: 'E'
  scope: {project: '=project', tasks: '=' }
  templateUrl: '_tasks.html'
  controller: 'TasksCtrl'

