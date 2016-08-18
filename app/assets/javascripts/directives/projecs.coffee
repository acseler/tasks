'use strict'

@todoList.directive 'todoProjects', ->
  templateUrl: '_projects.html'
  transclude: true
  controller: 'ProjectCtrl'