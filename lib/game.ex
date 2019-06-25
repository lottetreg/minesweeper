defmodule Game do
  @exit_command "exit\n"

  def exit_command do
    @exit_command
  end

  def play(%GameState{status: :awaiting_first_move} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    case get_input(game_state.config.reader) do
      {:ok, input} ->
        move = translate_input_to_move(input)

        board =
          Board.reveal_tile(game_state.board, move)
          |> BombPlacer.place_bombs(game_state.config.randomizer)
          |> AdjacentBombCount.set_adjacent_bomb_counts()
          |> FloodFiller.flood_fill(move)

        game_state
        |> GameState.set_board(board)
        |> GameState.set_status(:in_progress)
        |> play()

      {:error, :exit} ->
        nil
    end
  end

  def play(%GameState{status: :in_progress} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    case get_input(game_state.config.reader) do
      {:ok, input} ->
        move = translate_input_to_move(input)

        case Board.select_tile(game_state.board, move) do
          {:ok, board} ->
            game_state
            |> GameState.set_board(board)
            |> update_game_state_status()
            |> play()

          {:error, :already_selected} ->
            message = "That tile has already been selected! Please try again.\n"
            game_state.config.writer.write(message)
            play(game_state)
        end

      {:error, :exit} ->
        nil
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

  defp get_input(reader) do
    reader.read()
    |> check_for_exit_command()
  end

  defp check_for_exit_command(input) do
    if input == @exit_command do
      {:error, :exit}
    else
      {:ok, input}
    end
  end

  defp translate_input_to_move(input) do
    Move.translate(input)
  end
end
