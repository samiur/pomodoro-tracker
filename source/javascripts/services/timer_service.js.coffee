app.service 'timerService',
  class TimerService
    start: =>
      @ticking = true

    stop: =>
      @ticking = false

    onFinished: =>
      @stop()
      @finished = true

    tick: =>
      if @ticking
        if @sec is 0
          @onFinished()
        else
          @sec--
        @timeout = $timeout(@tick, 1000)

    percentComplete: ->
      @sec*100/@startSec

    reset: (@sec) ->
      @timeout = @$timeout(@tick, 1000)
      @ticking = false
      @finished = false

    constructor: (@$timeout) ->
      @timeout = $timeout(@tick, 1000)
      @ticking = false
      @finished = false
