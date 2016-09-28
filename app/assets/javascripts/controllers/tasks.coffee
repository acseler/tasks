'use strict'

@todoList.controller 'TasksCtrl', [
  '$scope'
  'errorHandler'
  'taskService'
  '$translate'
  ($scope, errorHandler, taskService, $translate) ->

    $scope.createTask = (task) ->
      taskService.createTask(task).$promise.then(
        (data) ->
          $scope.initProjects()
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.deleteTask = (task) ->
      if confirm($translate.instant('delete_task'))
        taskService.deleteTask(task).$promise.then(
          (data) ->
            $scope.initProjects()
          (err) ->
            errorHandler.handleError(err)
        )

    $scope.updateTask = (task)->
      taskService.updateTask(task).$promise.then(
        (data) ->
          $scope.initProjects()
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.sortableOptions =
      stop: (e, ui) ->
        $scope.tasks.map((task, index) ->
          unless task.priority == index
            task.priority = index
            taskService.updateTask(task)
        )
      axis: 'y'
]