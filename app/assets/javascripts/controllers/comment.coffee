'use strict'

@todoList.controller 'commentCtrl', [
  '$scope'
  'commentService'
  ($scope, commentService) ->

    $scope.commentAddFlag = false

    $scope.deleteComment = ->
      commentService.deleteComment($scope.comment).$promise.then(
        (data) ->
          $scope.initComments()
          $scope.commentAddFlag = false
      )


]