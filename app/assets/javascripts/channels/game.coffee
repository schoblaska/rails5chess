App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    @printMessage("Waiting for opponent...")
    @install()

  received: (data) ->
    if data.action == "game_start"
      App.board.position("start")
      App.board.orientation(data.msg)
      @printMessage("Game started! You play as #{data.msg}.")
    else if data.action == "make_move"
      [source, target] = data.msg.split("-")

      App.board.move(data.msg)
      App.game.move
        from: source
        to: target
        promotion: "q"

  install: ->
    $(document).on "made_move", (event, move) =>
      @perform("make_move", move)

  printMessage: (message) ->
    $("#messages").append("<p>#{message}</p>")
