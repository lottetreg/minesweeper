defmodule Game do
  def play(%GameState{status: :awaiting_first_move} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)

    board =
      Board.select_tile(game_state.board, move)
      |> BombPlacer.place_bombs(game_state.config.randomizer)

    game_state
    |> GameState.set_board(board)
    |> GameState.set_status(:in_progress)
    |> play()
  end

  def play(%GameState{status: :in_progress} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)

    board = Board.select_tile(game_state.board, move)

    game_state
    |> GameState.set_board(board)
    |> update_game_state_status()
    |> play()
  end

  def play(%GameState{status: :player_lost} = game_state) do
    print_board(game_state.config.writer, game_state.board)
    game_state.config.writer.write("You lose!\n")
  end

  def play(%GameState{status: :player_won} = game_state) do
    print_board(game_state.config.writer, game_state.board)
    game_state.config.writer.write("You win!\n")
  end

  defp update_game_state_status(game_state) do
    cond do
      GameRules.player_lost?(game_state.board) ->
        GameState.set_status(game_state, :player_lost)

      GameRules.player_won?(game_state.board) ->
        GameState.set_status(game_state, :player_won)

      true ->
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
