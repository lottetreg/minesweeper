defmodule Game do
  def start(game_state) do
    case GameSetup.setup(game_state) do
      :exit -> nil
      game_state -> play(game_state)
    end
  end

  def play(%GameState{status: :awaiting_first_move} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    case get_input(game_state.config.reader) do
      :exit ->
        nil

      input ->
        move = translate_input_to_move(input)

        board =
          Board.reveal_tile(game_state.board, move)
          |> BombPlacer.place_bombs(game_state.config.randomizer, game_state.number_of_bombs)
          |> AdjacentBombCount.set_adjacent_bomb_counts()
          |> FloodFiller.flood_fill(move)

        game_state
        |> GameState.set_board(board)
        |> GameState.set_status(:in_progress)
        |> check_for_win_or_loss()
        |> play()
    end
  end

  def play(%GameState{status: :in_progress} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    case get_input(game_state.config.reader) do
      :exit ->
        nil

      input ->
        move = translate_input_to_move(input)

        case Board.select_tile(game_state.board, move) do
          {:ok, board} ->
            game_state
            |> GameState.set_board(board)
            |> check_for_win_or_loss()
            |> play()

          {:error, :already_selected} ->
            "That tile has already been selected! Please try again."
            |> Message.format()
            |> game_state.config.writer.write()

            play(game_state)
        end
    end
  end

  def play(%GameState{status: :player_lost} = game_state) do
    print_board(game_state.config.writer, game_state.board)

    Message.format("You lose!")
    |> game_state.config.writer.write()
  end

  def play(%GameState{status: :player_won} = game_state) do
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

  defp print_board(writer, board) do
    writer.write(BoardPresenter.present(board))
  end

  defp get_input(reader) do
    reader.read()
    |> InputFilter.check_for_exit_command()
  end

  defp translate_input_to_move(input) do
    Move.translate(input)
  end
end
