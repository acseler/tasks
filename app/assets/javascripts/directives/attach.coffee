'use strict'

@todoList.directive 'attachTemplate', ->
  restrict: 'C'
  replace: true
  scope: { file: '=', index: '=', deleteFile: '=' }
  templateUrl: '_attach.html'
  controller: 'attachCtrl'