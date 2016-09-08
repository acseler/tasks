'use strict'

@todoList.controller 'TaskCtrl', [
  '$scope'
  '$translate'
  'errorHandler'
  'taskService'
  'commentService'
  ($scope, $translate, errorHandler, taskService, commentService) ->
    $scope.taskEditFlag = false
    $scope.showComments = false

    $scope.initComments = ->
      commentService.getComments($scope.task.id).$promise.then(
        (data) ->
          $scope.comments = data
      )

    $scope.initComments()

    $scope.deleteTask = (task) ->
      if confirm($translate.instant('delete_task'))
        taskService.deleteTask(task).$promise.then(
          (data) ->
            $scope.initTasks()
          (err) ->
            errorHandler.handleError(err)
        )

    $scope.showTaskEdit = ->
      $scope.taskEditFlag = !$scope.taskEditFlag
      $scope.taskTitleEdit = $scope.taskEditFlag && $scope.task.title || ''

    $scope.updateTask = (task)->
      taskService.updateTask(task).$promise.then(
        (data) ->
          $scope.initTasks()
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.assignDeadline = ->
      $scope.task_hover = false
      $scope.deadlineEdit = false
      $scope.updateTask($scope.task)
]