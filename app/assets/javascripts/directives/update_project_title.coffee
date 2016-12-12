'use strict'

@todoList.directive 'updateProjectTitle', ->
  restrict: 'E'
  scope: {
    proj: '='
    updateProject: '='
  }
  templateUrl: 'forms/update_project_title.html'
  controller: [
    '$scope'
    ($scope) ->
      $scope.updateProjectTitle = (project) ->
        $scope.updateProject(project: project)
  ]