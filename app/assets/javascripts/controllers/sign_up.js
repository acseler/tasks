'use strict';

angular.module('todoList')
  .controller('SignUpCtrl', ['$scope', '$location', '$auth', 'ngToast', '$translate',
                             function ($scope, $location, $auth, ngToast, $translate) {
    $scope.$on('auth:registration-email-error', function(ev, reason) {
      ngToast.create({
        className: 'danger',
        content: reason.errors.full_messages
      });
    });
    $scope.$on('auth:registration-email-success', function(ev, reason) {
      ngToast.create({
        className: 'info',
        content: $translate.instant('success_sign_in')
      });
    });
    $scope.handleRegBtnClick = function() {
      $auth.submitRegistration($scope.registrationForm)
        .then(function() {
          $auth.submitLogin({
            email: $scope.registrationForm.email,
            password: $scope.registrationForm.password
          });
        });
    };
  }]);