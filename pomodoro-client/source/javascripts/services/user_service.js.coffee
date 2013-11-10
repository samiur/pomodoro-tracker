app.factory 'User', ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
  class User extends RailsResource
    @configure url: 'http://localhost:5000/users', name: 'user', rootWrapping: false,
    serializer: railsSerializer ->
      @resource('tomatoes', 'Tomato')
]

app.factory 'Task', ['RailsResource', (RailsResource) ->
  class Task extends RailsResource
    @configure url: '/tasks', name: 'task', rootWrapping: false
]
