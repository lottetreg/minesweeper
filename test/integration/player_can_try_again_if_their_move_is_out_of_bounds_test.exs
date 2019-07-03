defmodule PlayerCanTryAgainIfTheirMoveIsOutOfBoundsTest do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player can try again if a subsequent move is out of bounds" do
    new_game_state(
      number_of_bombs: "1",
      bomb_locations: [{0, 0}],
      moves: ["0B", "10C"]
    )
    |> Game.start()

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

    assert_received {:write, "That move is out of bounds. Please enter a valid location.\n"}

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

  # test first move
  # test flags too

  # test "the player can try again if a subsequent move is not formatted correctly" do
  #   new_game_state(
  #     number_of_bombs: "1",
  #     bomb_locations: [{0, 0}],
  #     moves: ["0B", "C6"]
  #   )
  #   |> Game.start()

  #   assert_received {
  #     :write,
  #     [
  #       "   A B C D E F G H I J\n",
  #       [
  #         "0 | |1| | | | | | | | |\n",
  #         "1 | | | | | | | | | | |\n",
  #         "2 | | | | | | | | | | |\n",
  #         "3 | | | | | | | | | | |\n",
  #         "4 | | | | | | | | | | |\n",
  #         "5 | | | | | | | | | | |\n",
  #         "6 | | | | | | | | | | |\n",
  #         "7 | | | | | | | | | | |\n",
  #         "8 | | | | | | | | | | |\n",
  #         "9 | | | | | | | | | | |\n"
  #       ]
  #     ]
  #   }

  #   assert_received {:write, "Please provide a correctly-formatted number and letter (e.g. 1A)\n"}

  #   assert_received {
  #     :write,
  #     [
  #       "   A B C D E F G H I J\n",
  #       [
  #         "0 | |1| | | | | | | | |\n",
  #         "1 | | | | | | | | | | |\n",
  #         "2 | | | | | | | | | | |\n",
  #         "3 | | | | | | | | | | |\n",
  #         "4 | | | | | | | | | | |\n",
  #         "5 | | | | | | | | | | |\n",
  #         "6 | | | | | | | | | | |\n",
  #         "7 | | | | | | | | | | |\n",
  #         "8 | | | | | | | | | | |\n",
  #         "9 | | | | | | | | | | |\n"
  #       ]
  #     ]
  #   }
  # end
end
