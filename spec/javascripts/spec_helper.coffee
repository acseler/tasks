#= require application
#= require angular-mocks

beforeEach(module('todoList', 'ng-token-auth'))

beforeEach inject (_$httpBackend_,
                   _$compile_,
                   $rootScope,
                   $controller,
                   $injector,
                   $location,
                   $timeout,
                   $auth,
                   _$q_,
                   _projectService_) ->
  @scope = $rootScope.$new()
  @http = _$httpBackend_
  @q = _$q_
  @projectService = _projectService_
  @compile = _$compile_
  @location = $location
  @controller = $controller
  @injector = $injector
  @timeout = $timeout
  @auth = $auth
  @model = (name) =>
    @injector.get(name)
  @eventLoop =
    flush: =>
      @scope.$digest()
  @http.whenGET('sign_in.html').respond(201);

afterEach ->
  @http.resetExpectations()
  @http.verifyNoOutstandingExpectation()
