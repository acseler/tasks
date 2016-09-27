describe 'TaskCtrl', ->
  beforeEach ->
    @Comment = @model('commentService').comment()
    @Task = @model('taskService').task()
    @scope.task = new @Task({id: 1, title: 'Task 1', project_id: 1})
    @controller('TaskCtrl', {$scope: @scope, taskService: @commentService})
    @comments = [new @Comment({id: 1, message: 'Comment 1', task_id: @scope.task.id}),
                 new @Comment({id: 2, message: 'Comment 2', task_id: @scope.task.id})
    ]
    @commentForDelete = @comments[1]
    @newCommentMessage = 'Comment 3'
    @deferred = @q.defer()
    spyOn(@commentService, 'getComments').and.callFake(=>
      {$promise: @deferred.promise}
    )
    spyOn(@commentService, 'createComment').and.callFake( (_id, message) =>
      @comments.push(new @Comment({id: 3, message: message, task_id: @scope.task.id}))
      {$promise: @deferred.promise}
    )
    spyOn(@commentService, 'deleteComment').and.callFake( (comment) =>
      index = @comments.indexOf(comment)
      @comments.splice(index, 1)
      {$promise: @deferred.promise}
    )
    @http.whenGET('/api/v1/tasks/1/comments').respond(200, @comments)

  describe '#initComments', ->
    it 'initializes all comments of task', ->
      @deferred.resolve(@comments)
      @scope.initComments()
      @scope.$apply()
      expect(@scope.comments).toEqual(@comments)

  describe '#deleteComment', ->
    it 'deletes comment from task', ->
      @deferred.resolve(@comments)
      @scope.initComments()
      @scope.$apply()
      expect(@scope.comments).toContain(@commentForDelete)
      expect(@scope.comments.length).toBe(2)
      @scope.deleteComment(@commentForDelete)
      expect(@scope.comments).not.toContain(@commentForDelete)
      expect(@scope.comments.length).toBe(1)

  describe '#createComment', ->
    it 'creates new comment for task', ->
      @deferred.resolve(@comments)
      @scope.initComments()
      @scope.$apply()
      expect(@scope.comments.length).toBe(2)
      @scope.createComment(@newCommentMessage)
      expect(@scope.comments.length).toBe(3)
      expect(@scope.comments[2].message).toEqual(@newCommentMessage)

  describe '#deleteFile', ->
    it 'deletes file from files array', ->
      @scope.files = [
        { name: 'file 1' }
      ]
      expect(@scope.files.length).toBe(1)
      @scope.deleteFile(0)
      expect(@scope.files).toBeNull()
