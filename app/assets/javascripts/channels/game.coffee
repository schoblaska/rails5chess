App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    console.log("Game channel connected")

  # Called when the subscription has been terminated by the server
  disconnected: ->
    console.log("Game channel disconnected")

  # Called when there's incoming data on the websocket for this channel
  received: (data) ->
    console.log("Game channel received data...")
    console.log(data)
