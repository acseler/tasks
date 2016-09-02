'use strict'

@todoList.directive 'addNewComment', ->
  restrict: 'E'
  replace: true
  scope: {
    task: '='
    createComment: '&'
    initComments: '&'
  }
  templateUrl: 'forms/add_new_comment.html'
  controller: [
    '$scope'
    'commentService'
    'errorHandler'
    'Upload'
    ($scope, commentService, errorHandler, Upload) ->
      $scope.createComment = (message) ->
        commentService.createComment($scope.task.id, message).$promise.then(
          (data) ->
            if ($scope.files)
              uploadFiles(data)
            else
              $scope.initComments()
              $scope.commentAddFlag = false
              $scope.message = ''
          (err) ->
            errorHandler.handleError(err)
        )

      $scope.deleteFile = (index) ->
        $scope.files.splice(index, 1)
        $scope.files

      uploadFiles = (data)->
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
  ]