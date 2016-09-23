'use strict'

@todoList.directive 'updateTaskTitle', ->
  restrict: 'E'
  replace: true
  scope: {
    task: '='
    updateTask: '='
  }
  templateUrl: 'forms/update_task_title_form.html'
  controller: [
    '$scope'
    ($scope) ->
      $scope.taskTitleEdit = $scope.task.title
      $scope.updateTaskTitle = (taskTitle) ->
        $scope.task.title = taskTitle
        $scope.updateTask(task: $scope.task)
  ]