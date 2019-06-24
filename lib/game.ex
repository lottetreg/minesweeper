defmodule Game do
  def play(%GameState{status: :awaiting_first_move} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)

    {:ok, board} = Board.select_tile(game_state.board, move)

    board_with_bombs_and_counts =
      board
      |> BombPlacer.place_bombs(game_state.config.randomizer)
      |> AdjacentBombCount.update_adjacent_bomb_counts()

    game_state
    |> GameState.set_board(board_with_bombs_and_counts)
    |> GameState.set_status(:in_progress)
    |> play()
  end

  def play(%GameState{status: :in_progress} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)

    case Board.select_tile(game_state.board, move) do
      {:ok, board} ->
        game_state
        |> GameState.set_board(board)
        |> update_game_state_status()
        |> play()

      {:error, :already_selected} ->
        message = "You've already made that move! Please try again.\n"
        game_state.config.writer.write(message)
        play(game_state)
    end
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
