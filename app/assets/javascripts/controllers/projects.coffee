'use strict'

@todoList.controller 'ProjectCtrl', [
  '$scope'
  '$auth'
  'errorHandler'
  '$translate'
  'projectService'
  'taskService'
  ($scope, $auth, errorHandler, $translate, projectService, taskService) ->

    $scope.editedProjectId = null

    $scope.initProjects = ->
      projectService.getProjects().$promise.then(
        (data) ->
          $scope.projects = data
      )

    $scope.initProjects()

    $scope.addNewProject = (project) ->
      projectService.createProject(project, $scope.user).$promise.then(
        (data) ->
          $scope.newProjectFlag = false
          $scope.initProjects()
          $scope.project.title = ''
        (err) ->
          errorHandler.handleError(err)
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