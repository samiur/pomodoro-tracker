class Task
  constructor: (@name) ->
    @completed = false

app.factory 'TomatoSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @only('planTime', 'workTime', 'breakTime', 'planTimeFinished',
    'workTimeFinished', 'breakTimeFinished', 'tasks')
    @resource('tasks', 'Task')
    @nestedAttribute('tasks')
]

app.factory 'Tomato', ['$timeout', 'RailsResource', 'TomatoSerializer', ($timeout, RailsResource, TomatoSerializer) ->
  class Tomato extends RailsResource
    @configure url: '#{apiRootUrl}/users/{{userId}}/tomatoes/{{id}}', name: 'tomato',
    serializer: TomatoSerializer

    planStage:
      title: "Plan"
      text: "Awesome, you're ready for your next tomato!"

    breakStage:
      title: "Break"
      text: "Use this stage to plan for the next stage"

    workStage:
      title: "Work"
      text: "Back to work."

    constructor: (@breakTime, @planTime, @workTime, @userId) ->
      @planStage.sec = @planTime
      @breakStage.sec = @breakTime
      @workStage.sec = @workTime
      @planTimeFinished = 0
      @workTimeFinished = 0
      @breakTimeFinished = 0
      @stageIndex = 0
      @planStage.timeFinished = @planTimeFinished
      @workStage.timeFinished = @workTimeFinished
      @breakStage.timeFinished = @breakTimeFinished
      @stages = [@planStage, @workStage, @breakStage]
      @numStages = @stages.length
      @sec = @stages[@stageIndex].sec
      @completed = false
      @tasks = []
      @started = false

    start: =>
      @started = true
      console.log "Tomato started!"
      @sec = @stages[@stageIndex].sec
      @timeout = $timeout(@tick, 1000)

    stop: =>
      @started = false

    onFinished: =>
      console.log "Finished tomato!"
      @completed = true

    stageFinished: =>
      @stageIndex++
      if @stageIndex < @numStages
        @sec = @stages[@stageIndex].sec
      else
        @onFinished()
      @stop()

    currentStage: =>
      @stages[@stageIndex].title

    nextStage: =>
      if @stageIndex < (@numStages - 1)
        @stages[@stageIndex+1].title
      else
        null

    previousStage: =>
      @stages[@stageIndex - 1]

    newStage: =>
      @stages[@stageIndex]

    currentStageComplete: =>
      @sec*100/@stages[@stageIndex].sec

    addTask: (task) =>
      @tasks.push(new Task(task))

    removeTask: (idx) =>
      @tasks.splice(idx, 1)

    nextStage: =>
      console.log @stages[@stageIndex].text
      unless @completed or (@stageIndex >= @numStages)
        @start()

    isPlanning: =>
      @started and (@stageIndex == 0)

    isWorking: =>
      @started and (@stageIndex == 1)

    isBreaking: =>
      @started and (@stageIndex == 2)

    tick: =>
      console.log("Tick")
      if @started
        if @sec is 0
          @stageFinished()
        else
          @sec--
          switch @stageIndex
            when 0 then @planTimeFinished++
            when 1 then @workTimeFinished++
            when 2 then @breakTimeFinished++
          @timeout = $timeout(@tick, 1000)
]
