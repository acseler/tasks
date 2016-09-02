'use strict'

@todoList.directive 'commentTemplate', ->
  restrict: 'E'
  replace: true
  scope: {
    comment: '='
    initComments: '&'
  }
  templateUrl: '_comment.html'
  controller: 'commentCtrl'