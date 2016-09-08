'use strict'

@todoList.directive 'createTask', ->
  restrict: 'E'
  scope: {
    projectId: '='
    tasksCount: '='
    createTask: '&'
  }
  templateUrl: 'forms/create_task_form.html'
  controller: [
    '$scope'
    ($scope) ->
      $scope.taskForm =
        title: ''
        project_id: $scope.projectId
        completed: false

      $scope.emptyTasks = ->
        $scope.tasksCount == 0 && 'single-head' || 'non-single-head'

      $scope.createNewTask = (task) ->
        $scope.createTask(task: task).then(
          (data) ->
            $scope.taskForm.title = ''
        )
  ]