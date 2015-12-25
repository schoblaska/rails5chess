$ ->
  App.game = new Chess()

  cfg =
    draggable: true
    pieceTheme: "assets/chesspieces/alpha/{piece}.png"
    showNotation: false

    onDragStart: (source, piece, position, orientation) =>
      return !(App.game.game_over() ||
               (App.game.turn() == "w" && piece.search(/^b/) != -1) ||
               (App.game.turn() == "b" && piece.search(/^w/) != -1) ||
               (orientation == "white" && piece.search(/^b/) != -1) ||
               (orientation == "black" && piece.search(/^w/) != -1))

    onDrop: (source, target) =>
      move = App.game.move
        from: source
        to: target
        promotion: "q"

      if (move == null)
        # illegal move
        return "snapback"
      else
        $(document).trigger("made_move", move)

  App.board = ChessBoard("chessboard", cfg)
