'use strict'

@todoList.controller 'TaskCtrl', [
  '$scope'
  'errorHandler'
  'commentService'
  'Upload'
  ($scope, errorHandler, commentService, Upload) ->
    $scope.taskEditFlag = false
    $scope.showComments = false
    $scope.files = null

    $scope.initComments = ->
      commentService.getComments($scope.task.id).$promise.then(
        (data) ->
          $scope.comments = data
      )

    $scope.initComments()

    $scope.deleteComment = (comment) ->
      commentService.deleteComment(comment).$promise.then(
        (data) ->
          $scope.initComments()
      )

    $scope.createComment = (message) ->
      commentService.createComment($scope.task.id, message).$promise.then(
        (data) ->
          if ($scope.files)
            uploadFiles(data)
          else
            $scope.initComments()
        (err) ->
          errorHandler.handleError(err)
      )

      $scope.deleteFile = (index) ->
        $scope.files.splice(index, 1)
        $scope.files = null if $scope.files.length == 0
        $scope.files

      uploadFiles = (data)->
        for file in $scope.files
          Upload.upload(
            url: "api/v1/comments/#{data.id}/attachments"
            method: 'POST'
            file: file
          ).success(
            (data) ->
              $scope.commentAddFlag = false
              $scope.message = ''
              $scope.files = null
              $scope.initComments()
          ).error(
            (err) ->
              errorHandler.handleError(err)
          )

    # Tasks methods

    $scope.updateProjectTask = (task) ->
      $scope.updateTask(task: task).then(
        (data) ->
          $scope.showTaskEdit()
      )

    $scope.removeTask = (task) ->
      $scope.deleteTask(task: task)

    $scope.showTaskEdit = ->
      $scope.taskEditFlag = !$scope.taskEditFlag
      $scope.taskTitleEdit = $scope.taskEditFlag && $scope.task.title || ''

    $scope.assignDeadline = ->
      $scope.task_hover = false
      $scope.deadlineEdit = false
      $scope.updateProjectTask($scope.task)
]