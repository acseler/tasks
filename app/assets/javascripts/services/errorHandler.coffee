@todoList.factory 'errorHandler', [
  'ngToast'
  (ngToast) ->
    handleError: (err) ->
      error_messages = ''
      angular.forEach err.data.errors, (errors, field) ->
        error_messages += "<h4>#{toTitleCase(field)}</h4>
                                <p>#{errors.join(', ')}</p>"
      ngToast.create
        className: 'danger'
        content: error_messages
]

toTitleCase = (str) ->
  str.replace(
    /\w\S*/g
    (txt) ->
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
  )