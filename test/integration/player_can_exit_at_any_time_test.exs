defmodule PlayerCanExitAtAnyTimeTest do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player can exit by entering 'exit' when asked for the number of bombs" do
    new_game_state(number_of_bombs: "exit")
    |> Game.start()

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }
  end

  test "the player can exit by entering 'exit' when asked for their first move" do
    new_game_state(
      number_of_bombs: "1",
      moves: ["exit"]
    )
    |> Game.start()

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
  end

  test "the player can exit by entering 'exit' when asked for a subsequent move" do
    new_game_state(
      number_of_bombs: "1",
      bomb_locations: [{0, 0}],
      moves: ["0B", "exit"]
    )
    |> Game.start()

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
          "0 | |1| | | | | | | | |\n",
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
end
