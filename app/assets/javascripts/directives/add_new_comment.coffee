'use strict'

@todoList.directive 'addNewComment', ->
  restrict: 'E'
  replace: true
  scope: {
    task: '='
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
              $scope.commentAddFlag = false
              $scope.message = ''
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
  ]