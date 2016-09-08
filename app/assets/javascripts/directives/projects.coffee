'use strict'

@todoList.directive 'todoProjects', ->
  templateUrl: '_projects.html'
  scope: {
    projects: '='
    initProjects: '&'
  }
  transclude: true
  controller: [
    '$scope'
    ($scope)->
      $scope.initProjects()
  ]