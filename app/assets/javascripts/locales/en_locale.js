var translations = {
  sign_in: 'Sign in',
  sign_up: 'Sign up',
  sign_out: 'Sign out',
  email: 'Email',
  password: 'Password',
  password_confirm: 'Password confirmation',
  success_sign_in: 'Welcome to TodoList',
  failed_sign_in: 'Wrong email or password',
  good_bye: 'Good Bye'
};

todoList.config(['$translateProvider', function($translateProvider) {
  $translateProvider
    .translations('en', translations)
    .preferredLanguage('en');
}]);