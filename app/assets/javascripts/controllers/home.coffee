@todoList.controller 'HomeCtrl', [
  '$scope'
  'ngToast'
  '$translate'
  'projectService'
  'errorHandler'
  ($scope, ngToast, $translate, projectService, errorHandler) ->
    $scope.$on('auth:logout-success', (ev, user) ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('good_bye')}</p>"
    )

    $scope.initProjects = ->
      projectService.getProjects().$promise.then(
        (data) ->
          $scope.projects = data
      )

    $scope.initProjects()

    $scope.newProjectFlag = false
    $scope.showAddProject = ->
      $scope.newProjectFlag = true
    $scope.hideAddProject = ->
      $scope.newProjectFlag = false

    $scope.addNewProject = (project) ->
      projectService.createProject(project).$promise.then(
        (data) ->
          $scope.newProjectFlag = false
          $scope.initProjects()
        (err) ->
          errorHandler.handleError(err)
      )

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

    $scope.deleteProject = (project) ->
      if confirm($translate.instant('delete_project'))
        projectService.deleteProject(project).$promise.then(
          (data) ->
            $scope.initProjects()
          (err) ->
            errorHandler.handleError(err)
        )
]