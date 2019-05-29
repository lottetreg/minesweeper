defmodule GameTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "prints a given board" do
    out =
      MockWriter
      |> expect(:write, fn string -> send(self(), {:write, string}) end)

    Game.print_board(out, Board.new().board)

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

  test "returns a coordinate pair for the move 0A" do
    reader =
      MockReader
      |> expect(:read, fn -> "0A" end)

    move = Game.get_move(reader)

    assert(move == {0, 0})
  end

  test "returns a coordinate pair for the move 1A" do
    reader =
      MockReader
      |> expect(:read, fn -> "1A" end)

    move = Game.get_move(reader)

    assert(move == {1, 0})
  end

  test "returns a coordinate pair for the move 1B" do
    reader =
      MockReader
      |> expect(:read, fn -> "1B" end)

    move = Game.get_move(reader)

    assert(move == {1, 1})
  end

  test "returns a new board with the given move selected" do
    old_board = Board.new().board
    move = {1, 1}

    assert(old_board[1][1].selected == false)

    new_board = Game.select_board_tile(old_board, move)

    assert(new_board[1][1].selected == true)
  end
end
