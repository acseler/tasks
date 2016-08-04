'use strict';

angular.module('todoList')
  .controller('SignInCtrl', ['$auth', '$scope', 'ngToast', '$translate', '$state', function ($auth, $scope, ngToast, $translate, $state) {
    $scope.$on('auth:login-success', function (ev, user) {
      ngToast.create({
        className: 'info',
        content: $translate.instant('success_sign_in')
      });
    });
    $scope.$on('auth:login-error', function (ev, user) {
      ngToast.create({
        className: 'danger',
        content: $translate.instant('failed_sign_in')
      });
    });
    $scope.$on('auth:validation-success', function () {
      ngToast.create({
        className: 'info',
        content: $translate.instant('success_sign_in')
      });
    });
    $scope.handleBtnClick = function () {
      $auth.authenticate('facebook')
    };
  }]);