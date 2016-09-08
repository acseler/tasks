'use strict'

@todoList.directive 'todoProject', ->
  templateUrl: '_project.html'
  scope: {
    project: '='
    initProjects: '&'
  }
  transclude: true
  controller: 'ProjectCtrl'