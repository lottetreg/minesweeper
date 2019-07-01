defmodule PlayerIsToldToTryAgainIfTheyReenterAMoveTest do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player is told to try again if they reenter a move" do
    new_game_state(
      number_of_bombs: "1",
      bomb_locations: [{0, 0}],
      moves: ["6C", "6C"]
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

    assert_received {:write, "That tile has already been selected! Please try again.\n"}

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
  end
end
