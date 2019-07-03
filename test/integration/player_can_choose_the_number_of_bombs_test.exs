defmodule PlayerCanChooseTheNumberOfBombsTest do
  use ExUnit.Case

  import IntegrationTestHelper

  test "the player can try again if they enter a non-digit" do
    new_game_state(number_of_bombs: "2A")
    |> Game.start()

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }

    assert_received {
      :write,
      "Please enter a number (1 to 99).\n"
    }

    assert_received {
      :write,
      "Enter the number of mines to place on the board (1 to 99).\n"
    }
  end

  test "the player tries to place fewer than 1 bomb on the board" do
    new_game_state(number_of_bombs: "0")
    |> Game.start()

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
    new_game_state(number_of_bombs: "100")
    |> Game.start()

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
    new_game_state(
      number_of_bombs: "1",
      bomb_locations: [{0, 0}],
      moves: ["4D"]
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

  test "the player chooses to place 99 bombs on the board" do
    new_game_state(
      number_of_bombs: "99",
      moves: ["0A"]
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
  end
end
