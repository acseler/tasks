'use strict'
@todoList.controller 'SignUpCtrl', [
  '$scope'
  '$location'
  '$auth'
  'ngToast'
  '$translate'
  ($scope, $location, $auth, ngToast, $translate) ->
    $scope.$on 'auth:registration-email-error', (ev, reason) ->
      ngToast.create
        className: 'danger'
        content: "<p>#{reason.errors.full_messages}</p>"

    $scope.$on 'auth:registration-email-success', (ev, reason) ->
      ngToast.create
        className: 'info'
        content: "<p>#{$translate.instant('success_sign_in')}</p>"

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration($scope.registrationForm).then ->
        $auth.submitLogin
          email: $scope.registrationForm.email
          password: $scope.registrationForm.password
]