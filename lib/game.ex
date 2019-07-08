defmodule Game do
  def start(game_state) do
    case GameSetup.setup(game_state) do
      {:exit, _} -> nil
      game_state -> play(game_state)
    end
  end

  defp play(%GameState{status: :awaiting_first_move} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    parsed_input =
      game_state.config.reader.read()
      |> InputParser.parse_input()

    case parsed_input do
      {:exit, _} ->
        nil

      {:flag, location} ->
        case Board.flag_or_unflag_tile(game_state.board, location) do
          {:ok, board} ->
            game_state
            |> GameState.set_board(board)
            |> play()

          {:error, :out_of_bounds} ->
            "That move is out of bounds. Please enter a valid location."
            |> try_again_with_message(game_state)
        end

      {:move, location} ->
        case Board.select_tile(game_state.board, location) do
          {:ok, board} ->
            board =
              board
              |> BombPlacer.place_bombs(game_state.config.randomizer, game_state.number_of_bombs)
              |> AdjacentBombCount.set_adjacent_bomb_counts()
              |> FloodFiller.flood_fill(location)

            game_state
            |> GameState.set_board(board)
            |> GameState.set_status(:in_progress)
            |> check_for_win_or_loss()
            |> play()

          {:error, :out_of_bounds} ->
            "That move is out of bounds. Please enter a valid location."
            |> try_again_with_message(game_state)
        end

      # explicit with 'when'?
      _ ->
        "Please provide a correctly-formatted number and letter (e.g. 1A)"
        |> try_again_with_message(game_state)
    end
  end

  defp play(%GameState{status: :in_progress} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    parsed_input =
      game_state.config.reader.read()
      |> InputParser.parse_input()

    case parsed_input do
      {:exit, _} ->
        nil

      {:flag, location} ->
        case Board.flag_or_unflag_tile(game_state.board, location) do
          {:ok, board} ->
            game_state
            |> GameState.set_board(board)
            |> check_for_win_or_loss()
            |> play()

          {:error, :out_of_bounds} ->
            "That move is out of bounds. Please enter a valid location."
            |> try_again_with_message(game_state)

          {:error, :cannot_flag_revealed_tile} ->
            "You can't flag a tile that has already been revealed!"
            |> try_again_with_message(game_state)
        end

      {:move, location} ->
        case Board.select_tile_with_floodfill(game_state.board, location) do
          {:ok, board} ->
            game_state
            |> GameState.set_board(board)
            |> check_for_win_or_loss()
            |> play()

          {:error, :out_of_bounds} ->
            "That move is out of bounds. Please enter a valid location."
            |> try_again_with_message(game_state)

          {:error, :already_selected} ->
            "That tile has already been selected! Please try again."
            |> try_again_with_message(game_state)
        end

      # explicit expected errors with 'when'?
      _ ->
        "Please provide a correctly-formatted number and letter (e.g. 1A)"
        |> try_again_with_message(game_state)
    end
  end

  defp play(%GameState{status: :player_lost} = game_state) do
    FinalBoardPresenter.present(game_state.board)
    |> game_state.config.writer.write()

    Message.format("You lose!")
    |> game_state.config.writer.write()
  end

  defp play(%GameState{status: :player_won} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    Message.format("You win!")
    |> game_state.config.writer.write()
  end

  defp check_for_win_or_loss(game_state) do
    cond do
      GameRules.player_lost?(game_state.board) ->
        GameState.set_status(game_state, :player_lost)

      GameRules.player_won?(game_state.board) ->
        GameState.set_status(game_state, :player_won)

      true ->
        game_state
    end
  end

  defp try_again_with_message(message, game_state) do
    Message.format(message)
    |> game_state.config.writer.write()

    play(game_state)
  end

  defp print_board(writer, board) do
    writer.write(BoardPresenter.present(board))
  end
end
