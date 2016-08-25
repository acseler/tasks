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

    $scope.emptyTasks = ->
      $scope.tasks.length == 0 && 'single-head' || 'non-single-head'

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

    $scope.sortableOptions =
      stop: (e, ui) ->
        $scope.tasks.map( (t, i)->
          unless t.priority == i
            t.priority = i
            taskService.updateTask(t)
        )
      axis: 'y'
]