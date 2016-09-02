'use strict'

@todoList.controller 'SignInCtrl', [
  '$auth'
  '$scope'
  'ngToast'
  '$translate'
  ($auth, $scope, ngToast, $translate) ->

    $scope.$on 'auth:login-success', (ev, user) ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('success_sign_in')}</p>"

    $scope.$on 'auth:login-error', (ev, user) ->
      ngToast.create
        className: 'danger'
        content: "<p>#{$translate.instant('failed_sign_in')}</p>"

    $scope.$on 'auth:validation-success', ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('success_sign_in')}</p>"

    $scope.handleBtnClick = ->
      $auth.authenticate 'facebook'
]