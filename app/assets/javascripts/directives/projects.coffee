'use strict'

@todoList.directive 'todoProjects', ->
  templateUrl: '_projects.html'
  scope: {
    projects: '='
    initProjects: '&'
    updateProject: '&'
    deleteProject: '&'
  }
  transclude: true
  controller: [
    '$scope'
    ($scope) ->
  ]
