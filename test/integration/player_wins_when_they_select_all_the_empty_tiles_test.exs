defmodule PlayerWinsWhenTheySelectAllTheEmptyTilesTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  setup :verify_on_exit!

  test "the player wins when all of the empty tiles have been revealed" do
    horizontal_coordinate_pairs = [
      {4, 0},
      {4, 1},
      {4, 2},
      {4, 3},
      {4, 4},
      {4, 5},
      {4, 6},
      {4, 7},
      {4, 8},
      {4, 9}
    ]

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(horizontal_coordinate_pairs)

    number_of_bombs = "10"
    first_move = "0A"
    second_move = "9J"

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> first_move end)
      |> expect(:read, fn -> second_move end)

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
          "0 |0|0|0|0|0|0|0|0|0|0|\n",
          "1 |0|0|0|0|0|0|0|0|0|0|\n",
          "2 |0|0|0|0|0|0|0|0|0|0|\n",
          "3 |2|3|3|3|3|3|3|3|3|2|\n",
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
          "0 |0|0|0|0|0|0|0|0|0|0|\n",
          "1 |0|0|0|0|0|0|0|0|0|0|\n",
          "2 |0|0|0|0|0|0|0|0|0|0|\n",
          "3 |2|3|3|3|3|3|3|3|3|2|\n",
          "4 | | | | | | | | | | |\n",
          "5 |2|3|3|3|3|3|3|3|3|2|\n",
          "6 |0|0|0|0|0|0|0|0|0|0|\n",
          "7 |0|0|0|0|0|0|0|0|0|0|\n",
          "8 |0|0|0|0|0|0|0|0|0|0|\n",
          "9 |0|0|0|0|0|0|0|0|0|0|\n"
        ]
      ]
    }

    assert_received {:write, "You win!\n"}
  end
end
