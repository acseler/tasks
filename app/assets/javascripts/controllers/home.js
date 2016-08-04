'use strict';

angular.module('todoList')
  .controller('HomeCtrl', ['$scope', '$auth', 'ngToast', '$translate',
               function ($scope, $auth, ngToast, $translate) {
    $scope.$on('auth:logout-success', function(ev, user){
      ngToast.create({
        className: 'info',
        content: $translate.instant('good_bye')
      });
    });
  }]);