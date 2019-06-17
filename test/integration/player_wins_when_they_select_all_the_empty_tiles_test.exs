defmodule PlayerWinsWhenTheySelectAllTheEmptyTilesTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "the player wins when they select all the empty tiles" do
    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return_first_row()

    reader =
      MockReader
      |> allow_user_to_select_all_but_first_row()

    writer =
      MockWriter
      |> expect(:write, 92, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: randomizer
      })

    Game.play(game_state)

    assert_received {:write, "You win!\n"}
  end

  defp allow_random_coordinate_pair_to_return_first_row(mock_randomizer) do
    MockRandomizerHelper.allow_random_coordinate_pair_to_return(mock_randomizer)
  end

  defp allow_user_to_select_all_but_first_row(mock_reader) do
    second_row_number = 1
    last_row_number = 9
    column_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

    Enum.each(second_row_number..last_row_number, fn row_number ->
      Enum.each(column_letters, fn col_letter ->
        expect(mock_reader, :read, fn -> Integer.to_string(row_number) <> col_letter end)
      end)
    end)

    mock_reader
  end
end
