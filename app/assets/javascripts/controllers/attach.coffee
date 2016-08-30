'use strict'

@todoList.controller 'attachCtrl', [
  '$scope'
  'ngToast'
  '$translate'
  'errorHandler'
  'commentService'
  '$rootScope'
  ($scope, ngToast, $translate, errorHandler, commentService, $rootScope) ->
    $scope.removeFile = ->
      $scope.deleteFile($scope.index)
]