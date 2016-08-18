@todoList.factory 'taskService', [
  '$resource'
  ($resource) ->
    Task = $resource(
      '/api/v1/projects/:project_id/tasks/:id'
      project_id: '@project_id'
      id: '@id'
      { update: { method: 'PUT' } }
    )

    getTasks: (projectId)->
      Task.query({project_id: projectId})

    createTask: (task)->
      Task.save({ project_id: task.project_id }, task)
]