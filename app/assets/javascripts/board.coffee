$ ->
  App.chess = new Chess()

  cfg =
    draggable: true
    pieceTheme: "assets/chesspieces/alpha/{piece}.png"
    showNotation: false

    onDragStart: (source, piece, position, orientation) =>
      # make sure the player is allowed to pick up the piece
      return !(App.chess.game_over() ||
               (App.chess.turn() == "w" && piece.search(/^b/) != -1) ||
               (App.chess.turn() == "b" && piece.search(/^w/) != -1) ||
               (orientation == "white" && piece.search(/^b/) != -1) ||
               (orientation == "black" && piece.search(/^w/) != -1))

    onDrop: (source, target) =>
      move = App.chess.move
        from: source
        to: target
        promotion: "q"

      if (move == null)
        # illegal move
        return "snapback"
      else
        App.game.perform("make_move", move)
        App.board.position(App.chess.fen(), false)

  App.board = ChessBoard("chessboard", cfg)
