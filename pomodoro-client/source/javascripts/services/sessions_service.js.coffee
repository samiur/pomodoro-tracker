app.factory 'Session', ['$http', '$cookieStore', '$q', 'User', ($http, $cookieStore, $q, User) ->
  class Session
    @loggedIn: ->
      @authToken()

    @authToken: ->
      $cookieStore.get('authToken')

    @email: ->
      $cookieStore.get('email')

    clearKeys = ->
      $cookieStore.remove('email')
      $cookieStore.remove('authToken')

    @user: null

    @currentUser: ->
      deferred = $q.defer()
      if @loggedIn()
        if @user
          deferred.resolve(@user)
        else
          $http.get('http://localhost:5000/users/me', {params: {user_email: @email(),
          user_token: @authToken()}}).success((data, status) ->
            @user = new User(data.user)
            deferred.resolve(@user)
          )
          .error((data, status) ->
            clearKeys()
            deferred.reject(status)
          )
          deferred.promise
      else
        null

    @signIn: (email, password) ->
      deferred = $q.defer()
      $http.post('http://localhost:5000/users/sign_in', {email: email, password: password}).
      success((data, status) ->
        @loggedIn = true
        user = data.user
        @authToken = data.authentication_token
        $cookieStore.put('email', email)
        $cookieStore.put('authToken', authToken)
        deferred.resolve(data)
      ).error((data, status) ->
        deferred.reject(status)
      )
      deferred.promise

    @signOut: () ->
      if @loggedIn()
        deferred = $q.defer()
        $http.delete('http://localhost:5000/users/sign_out', {params: {authentication_token: @authToken()}}).
        success((data, status) ->
          deferred.resolve(data)
        ).error((data, status) ->
          deferred.resolve(status)
        )
        clearKeys()
        deferred.promise
      else
        null
]
