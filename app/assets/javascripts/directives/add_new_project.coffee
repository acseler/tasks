'use strict'

@todoList.directive 'addNewProject', ->
  restrict: 'E'
  replace: true
  scope: {
    addNewProject: '&'
    hideAddProject: '&'
  }
  templateUrl: 'forms/add_new_project_form.html'
  controller: [
    '$scope'
    ($scope) ->
      $scope.addProject = (project) ->
        $scope.addNewProject(project: project).then(
          (data) ->
            $scope.project.title = ''
            $scope.hideAddProject()
        )
  ]