'use strict'

@todoList.controller 'TaskCtrl', [
  '$scope'
  'ngToast'
  '$translate'
  'errorHandler'
  'taskService'
  '$rootScope'
  ($scope, ngToast, $translate, errorHandler, taskService, $rootScope) ->
    $scope.taskEditFlag = false

    $scope.updateTaskTitle = (task) ->
      task.title = $scope.taskTitleEdit
      taskService.updateTask(task).$promise.then(
        (data) ->
          $rootScope.$broadcast('taskUpdatedEvent')
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.deleteTask = (task) ->
      if confirm($translate.instant('delete_task'))
        taskService.deleteTask(task).$promise.then(
          (data) ->
            $rootScope.$broadcast('taskUpdatedEvent')
          (err) ->
            errorHandler.handleError(err)
        )

    $scope.showTaskEdit = ->
      $scope.taskEditFlag = !$scope.taskEditFlag
      $scope.taskTitleEdit = $scope.taskEditFlag && $scope.task.title || ''
]