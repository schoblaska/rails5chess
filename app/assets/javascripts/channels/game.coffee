App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    @printMessage("Waiting for opponent...")

  received: (data) ->
    switch data.action
      when "game_start"
        App.board.position("start")
        App.board.orientation(data.msg)
        @printMessage("Game started! You play as #{data.msg}.")
      when "make_move"
        [source, target] = data.msg.split("-")

        App.board.move(data.msg)
        App.chess.move
          from: source
          to: target
          promotion: "q"
      when "opponent_forfeits"
        @printMessage("Opponent forfeits. You win!")

  printMessage: (message) ->
    $("#messages").append("<p>#{message}</p>")
