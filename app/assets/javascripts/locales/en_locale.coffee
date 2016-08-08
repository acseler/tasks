'use strict'

translations =
  sign_in: 'Sign in'
  sign_up: 'Sign up'
  sign_out: 'Sign out'
  email: 'Email'
  password: 'Password'
  password_confirm: 'Password confirmation'
  success_sign_in: 'Welcome to TodoList'
  failed_sign_in: 'Wrong email or password'
  good_bye: 'Good Bye'
  simple_todo: 'SIMPLE TODO LISTS'
  from_ruby: 'FROM RUBY GARAGE'
  add_todo: 'Add TODO List'
  proj_title_placeholder: 'Enter project name'
  proj_title_new_placeholder: 'Ender new project name'
  add: 'Add'
  save: 'Save'
  delete_project: 'Do you realy want to remove this project?'

@todoList.config [
  '$translateProvider'
  ($translateProvider) ->
    $translateProvider.translations('en', translations).preferredLanguage 'en'
]