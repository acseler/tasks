@todoList.factory 'projectService', [
  '$resource'
  ($resource) ->
    Project = $resource(
      '/api/v1/projects/:id'
      { id: '@id' }
      { update: { method: 'PUT' } }
    )
    createProject: (project) ->
      Project.save(title: project.title)

    getProjects: ->
      Project.query()

    updateProject: (project) ->
      Project.update({id: project.id}, project)

    deleteProject: (project) ->
      Project.delete({id: project.id})
]