@todoList.controller 'ProjectCtrl', [
  '$scope'
  ($scope) ->
    $scope.editFlag = false

    $scope.removeProject = (project) ->
      $scope.deleteProject(project: project)
]