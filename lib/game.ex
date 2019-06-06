defmodule Game do
  def play(%GameState{status: :in_progress} = game_state, game_rules) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)
    board = Board.select_tile(game_state.board, move)

    game_state
    |> GameState.set_board(board)
    |> update_game_state_status(game_rules)
    |> play(game_rules)
  end

  def play(%GameState{status: :over} = game_state, _) do
    print_board(game_state.config.writer, game_state.board)
  end

  defp update_game_state_status(game_state, game_rules) do
    if game_rules.over? do
      GameState.set_status(game_state, :over)
    else
      game_state
    end
  end

  defp print_board(writer, board) do
    writer.write(BoardPresenter.present(board))
  end

  defp get_move(reader) do
    Move.translate(reader.read)
  end
end
