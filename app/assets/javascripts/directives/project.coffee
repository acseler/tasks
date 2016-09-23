'use strict'

@todoList.directive 'todoProject', ->
  templateUrl: '_project.html'
  scope: {
    project: '='
    initProjects: '&'
    updateProject: '='
    deleteProject: '='
  }
  transclude: true
  controller: 'ProjectCtrl'