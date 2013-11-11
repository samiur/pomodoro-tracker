app.factory 'User', ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
  class User extends RailsResource
    @configure url: '#{apiRootUrl}/users', name: 'user', rootWrapping: false,
    serializer: railsSerializer ->
      @resource('tomatoes', 'Tomato')
]

app.factory 'Task', ['RailsResource', (RailsResource) ->
  class Task extends RailsResource
    @configure url: '#{apiRootUrl}/tasks', name: 'task', rootWrapping: false
]
