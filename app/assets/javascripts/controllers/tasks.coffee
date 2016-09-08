'use strict'

@todoList.controller 'TasksCtrl', [
  '$scope'
  'errorHandler'
  'taskService'
  ($scope, errorHandler, taskService) ->
    $scope.initTasks = ->
      taskService.getTasks($scope.projectId).$promise.then(
        (data) ->
          $scope.tasks = data
      )

    $scope.createTask = (task) ->
      taskService.createTask(task).$promise.then(
        (data) ->
          $scope.initTasks()
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.sortableOptions =
      stop: (e, ui) ->
        $scope.tasks.map( (task, index) ->
          unless task.priority == index
            task.priority = index
            taskService.updateTask(task)
        )
      axis: 'y'
]