defmodule PlayerSeesIncorrectFlagsAtEnd do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player sees which flags were incorrect when they lose the game" do
    bomb_locations = [
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

    new_game_state(
      bomb_locations: bomb_locations,
      moves: ["6C", "0A -f", "1G -f", "1B"]
    )
    |> Game.start()

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

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 |F| | | | | | | | | |\n",
          "1 | | | | | | |F| | | |\n",
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

    assert_received {
      :write,
      [
        "   A B C D E F G H I J\n",
        [
          "0 |F| | | | | | | | | |\n",
          "1 | |*| | | | |X| | | |\n",
          "2 |1| |*| | | | | | | |\n",
          "3 |0|1| |*| | | | | | |\n",
          "4 |0|0|1| |*| | | | | |\n",
          "5 |0|0|0|1| |*| | | | |\n",
          "6 |0|0|0|0|1| |*| | | |\n",
          "7 |0|0|0|0|0|1| |*| | |\n",
          "8 |0|0|0|0|0|0|1| |*| |\n",
          "9 |0|0|0|0|0|0|0|1| |*|\n"
        ]
      ]
    }

    assert_received {:write, "You lose!\n"}
  end
end
