@todoList.controller 'ProjectCtrl', [
  '$scope'
  'errorHandler'
  '$translate'
  'projectService'
  ($scope, errorHandler, $translate, projectService) ->

    $scope.editFlag = false
  
    $scope.updateProject = (project) ->
      projectService.updateProject(project).$promise.then(
        (data) ->
          $scope.initProjects().then(
            (data) ->
              $scope.editFlag = false
          )
        (err) ->
          errorHandler.handleError(err)
      )
  
    $scope.deleteProject = (p) ->
      if confirm($translate.instant('delete_project'))
        projectService.deleteProject(p).$promise.then(
          (data) ->
            $scope.initProjects()
          (err) ->
            errorHandler.handleError(err)
        )
]