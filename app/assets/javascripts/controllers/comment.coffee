'use strict'

@todoList.controller 'commentCtrl', [
  '$scope'
  ($scope) ->
    $scope.removeComment = ->
      $scope.deleteComment(comment: $scope.comment)
]