defmodule GameSetup do
  @min_number_of_bombs 1
  @max_number_of_bombs 99

  def setup(game_state) do
    "Enter the number of mines to place on the board (1 to 99)."
    |> Message.format()
    |> game_state.config.writer.write()

    parsed_input =
      game_state.config.reader.read()
      |> InputParser.parse_input()

    case parsed_input do
      {:exit, input} ->
        {:exit, input}

      {:number, number} ->
        case validate_number_of_bombs(number) do
          {:ok, number_of_bombs} ->
            GameState.set_number_of_bombs(game_state, number_of_bombs)

          {:error, :invalid_number_of_bombs} ->
            Message.format("That's an invalid number of mines.")
            |> game_state.config.writer.write()

            setup(game_state)
        end

      _ ->
        Message.format("Please enter a number (1 to 99).")
        |> game_state.config.writer.write()

        setup(game_state)
    end
  end

  defp validate_number_of_bombs(number) do
    if valid_number_of_bombs?(number) do
      {:ok, number}
    else
      {:error, :invalid_number_of_bombs}
    end
  end

  defp valid_number_of_bombs?(number_of_bombs) do
    number_of_bombs >= @min_number_of_bombs &&
      number_of_bombs <= @max_number_of_bombs
  end
end
