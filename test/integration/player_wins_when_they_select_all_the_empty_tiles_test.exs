defmodule PlayerWinsWhenTheySelectAllTheEmptyTilesTest do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player wins when all of the bombs have been flagged and all of the empty tiles have been revealed" do
    new_game_state(
      number_of_bombs: "1",
      bomb_locations: [{9, 9}],
      moves: ["0A", "9J -f"]
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
          "0 |0|0|0|0|0|0|0|0|0|0|\n",
          "1 |0|0|0|0|0|0|0|0|0|0|\n",
          "2 |0|0|0|0|0|0|0|0|0|0|\n",
          "3 |0|0|0|0|0|0|0|0|0|0|\n",
          "4 |0|0|0|0|0|0|0|0|0|0|\n",
          "5 |0|0|0|0|0|0|0|0|0|0|\n",
          "6 |0|0|0|0|0|0|0|0|0|0|\n",
          "7 |0|0|0|0|0|0|0|0|0|0|\n",
          "8 |0|0|0|0|0|0|0|0|1|1|\n",
          "9 |0|0|0|0|0|0|0|0|1| |\n"
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
          "3 |0|0|0|0|0|0|0|0|0|0|\n",
          "4 |0|0|0|0|0|0|0|0|0|0|\n",
          "5 |0|0|0|0|0|0|0|0|0|0|\n",
          "6 |0|0|0|0|0|0|0|0|0|0|\n",
          "7 |0|0|0|0|0|0|0|0|0|0|\n",
          "8 |0|0|0|0|0|0|0|0|1|1|\n",
          "9 |0|0|0|0|0|0|0|0|1|F|\n"
        ]
      ]
    }

    assert_received {:write, "You win!\n"}
  end
end
