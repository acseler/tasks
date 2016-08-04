'use strict';

var todoList = angular.module('todoList', ['pascalprecht.translate', 'ngToast',
                                           'ngAnimate', 'ui.router', 'templates',
                                           'ng-token-auth', 'ngCookies']);

todoList.config(function($stateProvider, $urlRouterProvider, $locationProvider, $authProvider){
  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home.html',
      controller: 'HomeCtrl',
      resolve: {
        auth: function($auth, $state) {
          return $auth.validateUser()
            .catch(function(err){
              console.log(err);
              $state.go('sign_in');
            });
        }
      }
    })
    .state('sign_in', {
      url: '/sign_in',
      templateUrl: 'sign_in.html',
      controller: 'SignInCtrl'
    })
    .state('sign_up', {
      url: '/sign_up',
      templateUrl: 'sign_up.html',
      controller: 'SignUpCtrl'
    });

  $urlRouterProvider.otherwise('/home');

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  });

  $authProvider.configure({
    apiUrl:             '/api',
    omniauthWindowType: 'sameWindow',
    authProviderPaths: {
      facebook: '/auth/facebook'
    }
  })
});

todoList.run(['$rootScope', '$location', '$auth', '$state', function($rootScope, $location, $auth, $state) {

  $rootScope.$on('auth:login-success', function() {
    $state.go('home')
  });
  $rootScope.$on('auth:validation-success', function() {
    $state.go('home')
  });
  $rootScope.$on('auth:logout-success', function() {
    $state.go('sign_in')
  });
}]);

todoList.config(['ngToastProvider', function(ngToastProvider) {
  ngToastProvider.configure({
    animation: 'slide',
    horizontalPosition: 'left',
    maxNumber: 3,
    dismissButton: 'true'
  });
}]);

