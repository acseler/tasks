#= require spec_helper

describe 'HomeCtrl', ->
  beforeEach ->
    @controller('HomeCtrl', { $scope: @scope, projectService: @projectService })
    @Project = @model('projectService').project()
    @projects = [new @Project({ id: 1, title: 'Project 1' }),
                 new @Project({ id: 2, title: 'Project 2' })
    ]
    @newProject = new @Project({ id: '', title: 'New Project' })
    @createdProject = new @Project({ id: 3, title: 'New Project' })
    @udpatedProject = new @Project({id: 2, title: 'Updated Project'})
    @projectForDelete = @projects[1]
    @deferred = @q.defer();
    spyOn(@projectService, 'createProject').and.callFake( =>
      @projects.push(@createdProject)
      { $promise: @deferred.promise }
    )
    spyOn(@projectService, 'updateProject').and.callFake( =>
      for project in @projects
        project.title = @udpatedProject.title if project.id == @udpatedProject.id
      {$promise: @deferred.promise}
    )
    spyOn(@projectService, 'deleteProject').and.callFake( =>
      index = @projects.indexOf(@projectForDelete)
      @projects.splice(index, 1)
      {$promise: @deferred.promise}
    )
    spyOn(window, 'confirm').and.returnValue(true);

    @http.whenGET('/api/v1/projects').respond(200, @projects)

  describe '#initProjects', ->
    it 'initializes users projects', ->
      @scope.initProjects()
      @http.flush()
      expect(@scope.projects.length).toEqual(@projects.length)

  describe '#addNewProject', ->
    it 'creates new project', ->
      @deferred.resolve(@createdProject)
      @scope.addNewProject(@newProject)
      @http.flush()
      expect(@scope.projects).toContain(@createdProject)
      expect(@scope.newProjectFlag).toBeFalsy()

  describe '#updateProject', ->
    it 'updates project', ->
      @scope.initProjects()
      @scope.updateProject(@udpatedProject)
      @scope.$apply()
      @http.flush()
      expect(@scope.projects[1]).toEqual(@udpatedProject)
      expect(@scope.editFlag).toBeFalsy()

  describe '#deleteProject', ->
    it 'deletes project', ->
      @scope.initProjects()
      @scope.deleteProject(@projectForDelete)
      @scope.$apply()
      @http.flush()
      expect(@scope.projects.length).toBe(1)