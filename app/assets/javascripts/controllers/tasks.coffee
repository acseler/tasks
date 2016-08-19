'use strict'

@todoList.controller 'TasksCtrl', [
  '$scope'
  'errorHandler'
  '$translate'
  'taskService'
  '$rootScope'
  ($scope, errorHandler, $translate, taskService, $rootScope) ->
    $scope.taskForm =
      title: ''
      project_id: $scope.project
      completed: false

    $scope.initTasks = ->
      taskService.getTasks($scope.project).$promise.then(
        (data) ->
          $scope.tasks = data
      )

    $rootScope.$on('taskUpdatedEvent', ->
      $scope.initTasks()
    )

    $scope.createTask = () ->
      taskService.createTask($scope.taskForm).$promise.then(
        (data) ->
          $scope.initTasks()
          $scope.taskForm.title = ''
        (err) ->
          errorHandler.handleError(err)
      )
]