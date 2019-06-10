defmodule BoardTest do
  use ExUnit.Case

  test "a board has 10 rows" do
    assert(length(Board.new().board) == 10)
  end

  test "each row in a board has 10 elements" do
    Enum.each(Board.new().board, fn row ->
      assert(length(row) == 10)
    end)
  end

  test "each tile on a new board has not been selected" do
    Enum.each(Board.new().board, fn row ->
      Enum.each(row, fn tile ->
        assert(tile == :empty)
      end)
    end)
  end

  test "returns a tile at a given location" do
    board = Board.new().board

    tile = Board.get_tile(board, {0, 0})

    assert(tile == board |> Enum.at(0) |> Enum.at(0))
  end

  test "returns a new board with the tile selected at the given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) == :empty)

    new_board = Board.select_tile(old_board, {1, 1})

    assert(Board.get_tile(new_board, {1, 1}) == :selected)
  end
end
