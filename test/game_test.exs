defmodule GameTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "plays the game until it is over" do
    randomizer =
      MockRandomizer
      |> expect(:random_coordinate_pair, fn _, _ -> {0, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {1, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {2, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {3, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {4, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {5, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {6, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {7, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {8, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {9, 0} end)

    bomb_location = "0A"

    reader =
      MockReader
      |> expect(:read, fn -> "4E" end)
      |> expect(:read, fn -> bomb_location end)

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
          "1 | | | | | | | | | | |\n",
          "2 | | | | | | | | | | |\n",
          "3 | | | | | | | | | | |\n",
          "4 | | | | |X| | | | | |\n",
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
          "1 | | | | | | | | | | |\n",
          "2 | | | | | | | | | | |\n",
          "3 | | | | | | | | | | |\n",
          "4 | | | | |X| | | | | |\n",
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
