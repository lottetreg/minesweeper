defmodule FinalBoardPresenterTest do
  use ExUnit.Case

  test "present/1 distinguishes between flagged empty tiles and flagged bomb tiles" do
    board =
      Board.new().board
      |> Board.flag_tile({0, 0})
      |> Board.replace_tile({4, 4}, Tile.new(:bomb))
      |> Board.flag_tile({4, 4})

    presented_board = FinalBoardPresenter.present(board)

    expected_presented_board = [
      "   A B C D E F G H I J\n",
      [
        "0 |X| | | | | | | | | |\n",
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

    assert(presented_board == expected_presented_board)
  end

  test "present/1 shows hidden and revealed bomb tiles" do
    board =
      Board.new().board
      |> Board.replace_tile({4, 4}, Tile.new(:bomb))
      |> Board.replace_tile({0, 0}, Tile.new(:bomb))
      |> Board.reveal_tile({0, 0})

    presented_board = FinalBoardPresenter.present(board)

    expected_presented_board = [
      "   A B C D E F G H I J\n",
      [
        "0 |*| | | | | | | | | |\n",
        "1 | | | | | | | | | | |\n",
        "2 | | | | | | | | | | |\n",
        "3 | | | | | | | | | | |\n",
        "4 | | | | |*| | | | | |\n",
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
