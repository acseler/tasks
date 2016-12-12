'use strict'

@todoList.controller 'attachCtrl', [
  '$scope'
  ($scope) ->
    $scope.removeFile = ->
      $scope.deleteFile($scope.index)
]