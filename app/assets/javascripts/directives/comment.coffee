'use strict'

@todoList.directive 'commentTemplate', ->
  restrict: 'E'
  replace: true
  scope: {
    comment: '='
    deleteComment: '&'
  }
  templateUrl: '_comment.html'
  controller: 'commentCtrl'