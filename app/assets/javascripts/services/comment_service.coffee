@todoList.factory 'commentService', [
  '$resource'
  ($resource) ->
    Comment = $resource(
      '/api/v1/tasks/:task_id/comments/:id'
      task_id: '@task_id'
      id: '@id'
      {
        update: {url: '/api/v1/comments/:id/', method: 'PUT'}
        delete: {url: '/api/v1/comments/:id/', method: 'DELETE'}
      }
    )

    getComments: (taskId) ->
      Comment.query({task_id: taskId})

    createComment: (taskId, message) ->
      Comment.save({ task_id: taskId }, message: message)

    deleteComment: (comment) ->
      Comment.delete(id: comment.id)

    comment: ->
      Comment
]