'use strict'

@todoList.directive 'commentTemplate', ->
  restrict: 'E'
  replace: true
  scope: { comment: '=' }
  templateUrl: '_comment.html'
  controller: 'commentCtrl'