defmodule PlayerSeesNumberOfAdjacentBombsTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  setup :verify_on_exit!

  test "the player sees the number of adjacent bombs in a selected empty tile" do
    first_row_coordinate_pairs = [
      {0, 0},
      {0, 1},
      {0, 2},
      {0, 3},
      {0, 4},
      {0, 5},
      {0, 6},
      {0, 7},
      {0, 8},
      {0, 9}
    ]

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(first_row_coordinate_pairs)

    location_of_empty_tile_with_two_adjacent_bombs = "1A"
    location_of_bomb_tile = "0A"

    reader =
      MockReader
      |> expect(:read, fn -> location_of_empty_tile_with_two_adjacent_bombs end)
      |> expect(:read, fn -> location_of_bomb_tile end)

    writer =
      MockWriter
      |> expect(:write, 4, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: randomizer
      })

    Game.play(game_state)

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
          "1 |2| | | | | | | | | |\n",
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
          "0 |*| | | | | | | | | |\n",
          "1 |2| | | | | | | | | |\n",
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

    assert_received {:write, "You lose!\n"}
  end
end
