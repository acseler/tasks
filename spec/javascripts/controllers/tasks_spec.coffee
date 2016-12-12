describe 'TasksCtrl', ->
  beforeEach ->
    @controller('TasksCtrl', {$scope: @scope, taskService: @taskService})
    @Task = @model('taskService').task()
    @scope.projectId = 1
    @scope.initProjects = ->
    @tasks = [new @Task({id: 1, title: 'Task 1', project_id: @scope.projectId}),
              new @Task({id: 2, title: 'Task 2', project_id: @scope.projectId})
    ]
    @scope.tasks = @tasks
    @newTask = {title: 'New Task', project_id: @scope.projectId}
    @addedTask = new @Task({
      id: 3,
      title: 'New Task',
      project_id: @scope.projectId
    })
    @taskForDelete = @tasks[1]
    @updatedTask = {id: 2, title: 'Updated task', project_id: @scope.projectId}
    @deferred = @q.defer()
    spyOn(@taskService, 'createTask').and.callFake(=>
      @tasks.push(@addedTask)
      {$promise: @deferred.promise}
    )
    spyOn(@taskService, 'deleteTask').and.callFake(=>
      index = @tasks.indexOf(@taskForDelete)
      @tasks.splice(index, 1)
      {$promise: @deferred.promise}
    )
    spyOn(@taskService, 'updateTask').and.callFake( =>
      for task in @tasks
        task.title = @updatedTask.title if task.id == @updatedTask.id
      {$promise: @deferred.promise}
    )
    spyOn(window, 'confirm').and.returnValue(true);

  describe '#deleteTask', ->
  it 'deletes task from project', ->
    expect(@scope.tasks).toBeDefined()
    expect(@scope.tasks.length).toBe(2)
    @scope.deleteTask(@taskForDelete)
    @scope.$apply()
    expect(@scope.tasks.length).toBe(1)

  describe '#createTask', ->
    it 'creates new task for project', ->
      expect(@scope.tasks).toBeDefined()
      expect(@scope.tasks.length).toBe(2)
      @scope.createTask(@newTask)
      expect(@scope.tasks.length).toBe(3)
      expect(@scope.tasks[2].title).toEqual('New Task')

  describe '#updateTask', ->
    it "updates project's task", ->
      expect(@scope.tasks).toBeDefined()
      expect(@scope.tasks.length).toBe(2)
      @scope.updateTask(@updatedTask)
      @scope.$apply()
      expect(@scope.tasks.length).toBe(2)
      expect(@scope.tasks[1].title).toEqual('Updated task')