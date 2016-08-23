'use strict'

@todoList = angular.module('todoList', [
  'pascalprecht.translate'
  'ngToast'
  'ngAnimate'
  'ui.router'
  'templates'
  'ng-token-auth'
  'ngCookies'
  'angular-loading-bar'
  'ngResource'
  'ui.sortable'
  'ui.bootstrap.datetimepicker'
])

@todoList.config ($stateProvider, $urlRouterProvider,
                 $locationProvider, $authProvider) ->
  $stateProvider.state('home',
    url: '/home'
    template: '<todo-home></todo-home>'
    resolve:
      auth : ($auth, $state) ->
        $auth.validateUser().catch (err) ->
          $state.go 'sign_in'

  )
  .state('sign_in',
    url: '/sign_in'
    templateUrl: 'sign_in.html'
    controller: 'SignInCtrl'
  )
  .state('sign_up',
    url: '/sign_up'
    templateUrl: 'sign_up.html'
    controller: 'SignUpCtrl'
  )

  $urlRouterProvider.otherwise '/home'

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $authProvider.configure
    apiUrl: '/api'
    omniauthWindowType: 'sameWindow'
    authProviderPaths:
      facebook: '/auth/facebook'

@todoList.run [
  '$rootScope'
  '$location'
  '$auth'
  '$state'
  ($rootScope, $location, $auth, $state) ->
    $rootScope.$on 'auth:login-success', ->
      $state.go 'home'
    $rootScope.$on 'auth:validation-success', ->
      $state.go 'home'
    $rootScope.$on 'auth:logout-success', ->
      $state.go 'sign_in'
]

@todoList.config ['ngToastProvider', (ngToastProvider) ->
  ngToastProvider.configure
    animation: 'slide'
    horizontalPosition: 'left'
    maxNumber: 3
    dismissButton: 'true'
    timeout: 5000
]