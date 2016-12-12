'use strict'

@todoList.directive 'addNewComment', ->
  restrict: 'E'
  replace: true
  scope: {
    createComment: '&'
    deleteFile: '&'
    files: '='
  }
  templateUrl: 'forms/add_new_comment.html'
  controller: [
    '$scope'
    ($scope) ->
      $scope.addComment = ->
        $scope.createComment(message: $scope.message)
        $scope.commentAddFlag = false
        $scope.message = ''
  ]