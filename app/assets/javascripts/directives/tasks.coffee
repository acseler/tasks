'use strict'

@todoList.directive 'projectTasks', ->
  restrict: 'E'
  scope: { projectId: '=', tasks: '=', initProjects: '=' }
  templateUrl: '_tasks.html'
  controller: 'TasksCtrl'

