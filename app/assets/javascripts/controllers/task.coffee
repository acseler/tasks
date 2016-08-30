'use strict'

@todoList.controller 'TaskCtrl', [
  '$scope'
  'ngToast'
  '$translate'
  'errorHandler'
  'taskService'
  '$rootScope'
  'commentService'
  'Upload'
  ($scope, ngToast, $translate, errorHandler, taskService, $rootScope, commentService, Upload) ->
    $scope.taskEditFlag = false
    $scope.showComments = false

    $scope.createComment = (taskId, message) ->
      commentService.createComment(taskId, message).$promise.then(
        (data) ->
          if ($scope.files)
            for file in $scope.files
              Upload.upload(
                  url: "api/v1/comments/#{data.id}/attachments"
                  method: 'POST'
                  file: file
                ).success(
                  (data) ->
                    $scope.initComments()
                    $scope.commentAddFlag = false
                    $scope.message = ''
                    $scope.files = null
                ).error(
                  (err) ->
                    errorHandler.handleError(err)
              )
          else
            $scope.initComments()
            $scope.commentAddFlag = false
            $scope.message = ''
        (err) ->
          errorHandler.handleError(err)
      )


    $scope.updateTaskTitle = (task, taskTitle) ->
      task.title = taskTitle
      $scope.updateTask($scope.task)

    $scope.initComments = ->
      commentService.getComments($scope.task.id).$promise.then(
        (data) ->
          $scope.comments = data
      )

    $rootScope.$on('commentUpdatedEvent', ->
      $scope.initComments()
    )

    $scope.initComments()

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

    $scope.updateTask = (task)->
      taskService.updateTask(task).$promise.then(
        (data) ->
          $rootScope.$broadcast('taskUpdatedEvent')
        (err) ->
          errorHandler.handleError(err)
      )

    $scope.assignDeadline = ->
      $scope.task_hover = false
      $scope.deadlineEdit = false
      $scope.updateTask($scope.task)

    $scope.deleteFile = (index) ->
      $scope.files.splice(index, 1)
      $scope.files
]