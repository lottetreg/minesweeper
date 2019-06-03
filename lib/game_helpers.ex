defmodule GameHelpers do
  def update_status(game_state, game_rules) do
    if game_rules.over? do
      GameState.set_status(game_state, :over)
    else
      game_state
    end
  end

  def print_board(writer, board) do
    writer.write(BoardPresenter.present(board))
  end

  def select_board_tile(board, {x, y}) do
    put_in(board[x][y].selected, true)
  end

  def get_move(reader) do
    Move.translate(reader.read)
  end
end
