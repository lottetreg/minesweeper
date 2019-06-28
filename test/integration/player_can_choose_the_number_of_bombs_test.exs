defmodule PlayerCanChooseTheNumberOfBombsTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  test "the player tries to place fewer than 1 bomb on the board" do
    number_of_bombs = "0"

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> InputFilter.exit_command() end)

    writer =
      MockWriter
      |> expect(:write, 3, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: Randomizer
      })

    Game.start(game_state)

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }

    assert_received {
      :write,
      "That's an invalid number of mines.\n"
    }

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }
  end

  test "the player tries to place more than 99 bombs on the board" do
    number_of_bombs = "100"

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> InputFilter.exit_command() end)

    writer =
      MockWriter
      |> expect(:write, 3, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: Randomizer
      })

    Game.start(game_state)

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }

    assert_received {
      :write,
      "That's an invalid number of mines.\n"
    }

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }
  end

  test "the player chooses to place 1 bomb on the board" do
    number_of_bombs = "1"
    bomb_location = {0, 0}
    first_move = "4D"

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(bomb_location)

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> first_move end)

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
          "0 | |1|0|0|0|0|0|0|0|0|\n",
          "1 |1|1|0|0|0|0|0|0|0|0|\n",
          "2 |0|0|0|0|0|0|0|0|0|0|\n",
          "3 |0|0|0|0|0|0|0|0|0|0|\n",
          "4 |0|0|0|0|0|0|0|0|0|0|\n",
          "5 |0|0|0|0|0|0|0|0|0|0|\n",
          "6 |0|0|0|0|0|0|0|0|0|0|\n",
          "7 |0|0|0|0|0|0|0|0|0|0|\n",
          "8 |0|0|0|0|0|0|0|0|0|0|\n",
          "9 |0|0|0|0|0|0|0|0|0|0|\n"
        ]
      ]
    }

    assert_received {
      :write,
      "You win!\n"
    }
  end

  test "the player chooses to place 99 bombs on the board" do
    number_of_bombs = "99"
    first_move = "0A"

    reader =
      MockReader
      |> expect(:read, fn -> number_of_bombs end)
      |> expect(:read, fn -> first_move end)

    writer =
      MockWriter
      |> expect(:write, 4, fn string -> send(self(), {:write, string}) end)

    game_state =
      GameState.new()
      |> GameState.set_config(%{
        reader: reader,
        writer: writer,
        randomizer: Randomizer
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
          "0 |3| | | | | | | | | |\n",
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
      "You win!\n"
    }
  end

  test "the player chooses to place 10 bombs on a board" do
    number_of_bombs = "10"
    first_move = "0A"
    second_move = "9J"

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
