defmodule PlayerCanExitAtAnyTimeTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  test "the player can exit by entering 'exit' when asked for their first move" do
    exit_command = "exit\n"

    reader =
      MockReader
      |> expect(:read, fn -> exit_command end)

    writer =
      MockWriter
      |> expect(:write, 1, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: Randomizer
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
  end

  test "the player can exit by entering 'exit' when asked for a subsequent move" do
    first_move = "0A"
    exit_command = "exit\n"

    bomb_locations = [
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
      |> allow_random_coordinate_pair_to_return(bomb_locations)

    reader =
      MockReader
      |> expect(:read, fn -> first_move end)
      |> expect(:read, fn -> exit_command end)

    writer =
      MockWriter
      |> expect(:write, 2, fn string -> send(self(), {:write, string}) end)

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
  end
end
