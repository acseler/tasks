'use strict'

@todoList.controller 'ProjectCtrl', [
  '$scope'
  '$auth'
  'ngToast'
  '$translate'
  'projectService'
  ($scope, $auth, ngToast, $translate, projectService) ->
    $scope.$on('auth:logout-success', (ev, user) ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('good_bye')}</p>"
    )
    $scope.newProjectFlag = false
    $scope.editedProjectId = null

    $scope.initProjects = ->
      projectService.getProjects().$promise.then(
        (data) ->
          $scope.projects = data
      )

    $scope.initProjects()
    $scope.showAddProject = ->
      $scope.newProjectFlag = true

    $scope.addNewProject = (project) ->
      projectService.createProject(project).$promise.then(
        (data) ->
          $scope.newProjectFlag = false
          $scope.initProjects()
          $scope.project.title = ''
        (err) ->
          handleError(err)
      )

    $scope.showEditProject = (project) ->
      if $scope.editedProjectId == project.id
        $scope.editedProjectId = null
      else
        $scope.editedProjectId = project.id

    $scope.hideEditProject = ->
      $scope.editedProjectId = null

    $scope.updateProject = (project) ->
      projectService.updateProject(project).$promise.then(
        (data) ->
          $scope.initProjects()
          $scope.hideEditProject()
        (err) ->
          handleError(err)
      )

    $scope.deleteProject = (p) ->
      if confirm($translate.instant('delete_project'))
        projectService.deleteProject(p).$promise.then(
          (data) ->
            $scope.initProjects()
          (err) ->
            handleError(err)
        )

    toTitleCase = (str) ->
      str.replace(
        /\w\S*/g
        (txt) ->
          txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
      )

    handleError = (err) ->
      error_messages = ''
      angular.forEach err.data.errors, (errors, field) ->
        error_messages += "<h4>#{toTitleCase(field)}</h4>
                               <p>#{errors.join(', ')}</p>"
      ngToast.create
        className: 'danger'
        content: error_messages
]