defmodule PlayerIsToldToTryAgainIfTheyReenterAMoveTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  setup :verify_on_exit!

  test "the player is told to try again if they reenter a move" do
    diagonal_coordinate_pairs = [
      {0, 0},
      {1, 1},
      {2, 2},
      {3, 3},
      {4, 4},
      {5, 5},
      {6, 6},
      {7, 7},
      {8, 8},
      {9, 9}
    ]

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(diagonal_coordinate_pairs)

    number_of_bombs = "10"
    empty_tile_location = "6C"

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> empty_tile_location end)
      |> expect(:read, fn -> empty_tile_location end)
      |> expect(:read, fn -> InputFilter.exit_command() end)

    writer =
      MockWriter
      |> expect(:write, 5, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: randomizer
      })

    Game.start(game_state)

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 | | | | | | | | | | |\n",
          "1 | | | | | | | | | | |\n",
          "2 | | | | | | | | | | |\n",
          "3 | | | | | | | | | | |\n",
          "4 | | | | | | | | | | |\n",
          "5 | | | | | | | | | | |\n",
          "6 | | | | | | | | | | |\n",
          "7 | | | | | | | | | | |\n",
          "8 | | | | | | | | | | |\n",
          "9 | | | | | | | | | | |\n"
        ]
      ]
    }

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 | | | | | | | | | | |\n",
          "1 | | | | | | | | | | |\n",
          "2 |1| | | | | | | | | |\n",
          "3 |0|1| | | | | | | | |\n",
          "4 |0|0|1| | | | | | | |\n",
          "5 |0|0|0|1| | | | | | |\n",
          "6 |0|0|0|0|1| | | | | |\n",
          "7 |0|0|0|0|0|1| | | | |\n",
          "8 |0|0|0|0|0|0|1| | | |\n",
          "9 |0|0|0|0|0|0|0|1| | |\n"
        ]
      ]
    }

    assert_received {:write, "That tile has already been selected! Please try again.\n"}

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 | | | | | | | | | | |\n",
          "1 | | | | | | | | | | |\n",
          "2 |1| | | | | | | | | |\n",
          "3 |0|1| | | | | | | | |\n",
          "4 |0|0|1| | | | | | | |\n",
          "5 |0|0|0|1| | | | | | |\n",
          "6 |0|0|0|0|1| | | | | |\n",
          "7 |0|0|0|0|0|1| | | | |\n",
          "8 |0|0|0|0|0|0|1| | | |\n",
          "9 |0|0|0|0|0|0|0|1| | |\n"
        ]
      ]
    }
  end
end
