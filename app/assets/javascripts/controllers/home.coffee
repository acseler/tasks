@todoList.controller 'HomeCtrl', [
  '$scope'
  '$auth'
  'ngToast'
  '$translate'
  ($scope, $auth, ngToast, $translate) ->
    $scope.$on('auth:logout-success', (ev, user) ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('good_bye')}</p>"
    )

    $scope.newProjectFlag = false
    $scope.showAddProject = ->
      $scope.newProjectFlag = true
    $scope.hideAddProject = ->
      $scope.newProjectFlag = false
]