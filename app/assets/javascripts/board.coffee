$ ->
  game = new Chess()

  cfg =
    draggable: true
    pieceTheme: "assets/chesspieces/alpha/{piece}.png"
    showNotation: false

    onDragStart: (source, piece, position, orientation) =>
      return !(game.game_over() ||
               (game.turn() == "w" && piece.search(/^b/) != -1) ||
               (game.turn() == "b" && piece.search(/^w/) != -1) ||
               (orientation == "white" && piece.search(/^b/) != -1) ||
               (orientation == "black" && piece.search(/^w/) != -1))

    onDrop: (source, target) =>
      move = game.move
        from: source
        to: target
        promotion: "q"

      if (move == null)
        # illegal move
        return "snapback"

  App.board = ChessBoard("chessboard", cfg)
