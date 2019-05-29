defmodule Minesweeper do
  def main(_args) do
    board = Board.new().board
    Game.print_board(Writer, board)

    move = Game.get_move(Reader)

    new_board = Game.select_board_tile(board, move)
    Game.print_board(Writer, new_board)
  end
end
