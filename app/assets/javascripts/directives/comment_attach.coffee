'use strict'

@todoList.directive 'commentAttach', ->
  restrict: 'C'
  replace: true
  scope: { attach: '=' }
  templateUrl: '_comment_attach.html'
  controller: ['$scope', ($scope) ->
  ]