@todoList.factory 'taskService', [
  '$resource'
  ($resource) ->
    Task = $resource(
      '/api/v1/projects/:project_id/tasks/:id'
      project_id: '@project_id'
      id: '@id'
      {
        update: { url: '/api/v1/tasks/:id/', method: 'PUT'  }
        delete: { url: '/api/v1/tasks/:id/', method: 'DELETE' }
      }
    )

    getTasks: (projectId)->
      Task.query({project_id: projectId})

    createTask: (task)->
      console.log(task)
      Task.save({ project_id: task.project_id }, task)

    updateTask: (task) ->
      Task.update({project_id: task.project_id, id: task.id}, task)

    deleteTask: (task) ->
      Task.delete({project_id: task.project_id, id: task.id})
]