defmodule IntegrationTestHelper do
  import Mox

  def new_game_state(options) do
    reader =
      default_mock_reader(
        number_of_bombs: options[:number_of_bombs],
        moves: options[:moves]
      )

    writer =
      MockWriter
      |> stub(:write, fn string -> send(self(), {:write, string}) end)

    randomizer =
      if options[:bomb_locations] do
        MockRandomizer
        |> allow_random_coordinate_pair_to_return(options[:bomb_locations])
      else
        Randomizer
      end

    GameState.new()
    |> GameState.set_config(%{
      reader: reader,
      writer: writer,
      randomizer: randomizer
    })
  end

  defp default_mock_reader(options) do
    MockReader
    |> expect(:read, fn -> options[:number_of_bombs] || "10" end)

    Enum.each(options[:moves] || [], fn move ->
      MockReader
      |> expect(:read, fn -> move end)
    end)

    MockReader
    |> stub(:read, fn -> InputParser.exit_command() end)
  end

  defp allow_random_coordinate_pair_to_return(
         MockRandomizer = mock_randomizer,
         [_ | _] = coordinate_pairs
       ) do
    Enum.each(coordinate_pairs, fn coordinate_pair ->
      expect(mock_randomizer, :random_coordinate_pair, fn _, _ ->
        coordinate_pair
      end)
    end)

    mock_randomizer
  end
end
