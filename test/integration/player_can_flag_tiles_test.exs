defmodule PlayerCanFlagTilesTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  setup :verify_on_exit!

  test "the player can flag a tile on their first move" do
    reader = default_mock_reader(moves: ["3A -f"])
    game_state = default_game_state(reader: reader)

    Game.start(game_state)

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 | | | | | | | | | | |\n",
          "1 | | | | | | | | | | |\n",
          "2 | | | | | | | | | | |\n",
          "3 |F| | | | | | | | | |\n",
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

  test "the player can flag a tile on their first move and second move" do
    reader = default_mock_reader(moves: ["0A -f", "0B -f"])
    game_state = default_game_state(reader: reader)

    Game.start(game_state)

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 |F| | | | | | | | | |\n",
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
          "0 |F|F| | | | | | | | |\n",
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

  test "the player can flag a bomb tile on their first move" do
    reader = default_mock_reader(moves: ["4E -f", "0A"])

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

    game_state = default_game_state(reader: reader, randomizer: randomizer)

    Game.start(game_state)

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 | | | | | | | | | | |\n",
          "1 | | | | | | | | | | |\n",
          "2 | | | | | | | | | | |\n",
          "3 | | | | | | | | | | |\n",
          "4 | | | | |F| | | | | |\n",
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
          "4 | | | | |F| | | | | |\n",
          "5 | | | | | | | | | | |\n",
          "6 | | | | | | | | | | |\n",
          "7 | | | | | | | | | | |\n",
          "8 | | | | | | | | | | |\n",
          "9 | | | | | | | | | | |\n"
        ]
      ]
    }
  end

  test "the player can flag a bomb tile on their second move" do
    reader = default_mock_reader(moves: ["0A", "4E -f"])

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

    game_state = default_game_state(reader: reader, randomizer: randomizer)

    Game.start(game_state)

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
          "4 | | | | |F| | | | | |\n",
          "5 | | | | | | | | | | |\n",
          "6 | | | | | | | | | | |\n",
          "7 | | | | | | | | | | |\n",
          "8 | | | | | | | | | | |\n",
          "9 | | | | | | | | | | |\n"
        ]
      ]
    }
  end

  test "the player can flag an empty tile on their second move" do
    reader = default_mock_reader(moves: ["0A", "7B -f"])

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

    game_state = default_game_state(reader: reader, randomizer: randomizer)

    Game.start(game_state)

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
          "5 | | | | | | | | | | |\n",
          "6 | | | | | | | | | | |\n",
          "7 | |F| | | | | | | | |\n",
          "8 | | | | | | | | | | |\n",
          "9 | | | | | | | | | | |\n"
        ]
      ]
    }
  end

  test "the player can flag a tile on their first move and reveal a tile on their second" do
    reader = default_mock_reader(moves: ["0A -f", "0B"])

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

    game_state = default_game_state(reader: reader, randomizer: randomizer)

    Game.start(game_state)

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 |F| | | | | | | | | |\n",
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
          "0 |F|0|0|0|0|0|0|0|0|0|\n",
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

  test "the player cannot flag a tile that has already been revealed" do
    reader = default_mock_reader(moves: ["0A", "0A -f"])

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

    game_state = default_game_state(reader: reader, randomizer: randomizer)

    Game.start(game_state)

    assert_received {
      :write,
      "You can't flag a tile that has already been revealed!\n"
    }
  end

  test "flagging an already-flagged tile will unflag it" do
    reader = default_mock_reader(moves: ["0A -f", "0A -f"])

    game_state = default_game_state(reader: reader)

    Game.start(game_state)

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
          "0 |F| | | | | | | | | |\n",
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

  defp default_mock_reader(options) do
    bomb_count = "10"

    MockReader
    |> expect(:read, fn -> bomb_count end)

    Enum.each(options[:moves] || [], fn move ->
      MockReader
      |> expect(:read, fn -> move end)
    end)

    MockReader
    |> expect(:read, fn -> InputParser.exit_command() end)
  end

  defp default_game_state(options) do
    writer =
      MockWriter
      |> stub(:write, fn string -> send(self(), {:write, string}) end)

    GameState.new()
    |> GameState.set_config(%{
      reader: options[:reader],
      writer: writer,
      randomizer: options[:randomizer]
    })
  end
end
