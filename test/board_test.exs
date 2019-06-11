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
        assert(tile.state == :unselected)
      end)
    end)
  end

  test "each tile on a new board is an empty tile" do
    Enum.each(Board.new().board, fn row ->
      Enum.each(row, fn tile ->
        assert(Tile.is_a?(tile, EmptyTile))
      end)
    end)
  end

  test "returns all tiles in a flat structure" do
    board = Board.new().board

    assert(length(Board.all_tiles(board)) == 100)
  end

  test "returns a tile at a given location" do
    board = Board.new().board

    tile = Board.get_tile(board, {0, 0})

    assert(tile == board |> Enum.at(0) |> Enum.at(0))
  end

  test "returns a new board with a replaced tile at a given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_a?(EmptyTile))

    new_board = Board.replace_tile(old_board, {1, 1}, BombTile.new())

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_a?(BombTile))
  end

  test "returns a new board with the tile selected at the given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}).state == :unselected)

    new_board = Board.select_tile(old_board, {1, 1})

    assert(Board.get_tile(new_board, {1, 1}).state == :selected)
  end

  test "takes a function that returns a new board and calls it for every tile in the board" do
    old_board = Board.new().board

    all_tiles_are_unselected? =
      Board.all_tiles(old_board)
      |> Enum.all?(fn tile -> tile.state == :unselected end)

    assert(all_tiles_are_unselected? == true)

    new_board = Board.update_all_tiles(old_board, &select_tile/3)

    all_tiles_are_selected? =
      Board.all_tiles(new_board)
      |> Enum.all?(fn tile -> tile.state == :selected end)

    assert(all_tiles_are_selected? == true)
  end

  defp select_tile(board, tile, tile_location) do
    Board.replace_tile(board, tile_location, Tile.select(tile))
  end
end
