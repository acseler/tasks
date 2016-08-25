'use strict'

@todoList.controller 'commentCtrl', [
  '$scope'
  'ngToast'
  '$translate'
  'errorHandler'
  'commentService'
  '$rootScope'
  ($scope, ngToast, $translate, errorHandler, commentService, $rootScope) ->

    $scope.commentAddFlag = false

    $scope.deleteComment = ->
      commentService.deleteComment($scope.comment).$promise.then(
        (data) ->
          $rootScope.$broadcast('commentUpdatedEvent')
      )

]