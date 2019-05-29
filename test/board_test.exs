defmodule BoardTest do
  use ExUnit.Case

  test "a board has 10 rows" do
    assert(map_size(Board.new().board) == 10)
  end

  test "each row in a board has 10 elements" do
    Enum.each(Board.new().board, fn {_, row} ->
      assert(map_size(row) == 10)
    end)
  end

  test "each tile on a new board has not been selected" do
    Enum.each(Board.new().board, fn {_, row} ->
      Enum.each(row, fn {_, tile} ->
        assert(tile.selected == false)
      end)
    end)
  end
end
