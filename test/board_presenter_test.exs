defmodule BoardPresenterTest do
  use ExUnit.Case

  test "returns a list representation of the given blank board" do
    board = Board.new().board

    presented_board = BoardPresenter.present(board)

    expected_presented_board = [
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

    assert(presented_board == expected_presented_board)
  end

  test "returns a list representation of the given board with selected tiles" do
    board = Board.reveal_tile(Board.new().board, {2, 5})

    presented_board = BoardPresenter.present(board)

    expected_presented_board = [
      "   A B C D E F G H I J\n",
      [
        "0 | | | | | | | | | | |\n",
        "1 | | | | | | | | | | |\n",
        "2 | | | | | |0| | | | |\n",
        "3 | | | | | | | | | | |\n",
        "4 | | | | | | | | | | |\n",
        "5 | | | | | | | | | | |\n",
        "6 | | | | | | | | | | |\n",
        "7 | | | | | | | | | | |\n",
        "8 | | | | | | | | | | |\n",
        "9 | | | | | | | | | | |\n"
      ]
    ]

    assert(presented_board == expected_presented_board)
  end
end
