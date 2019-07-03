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
        assert(Tile.is_hidden?(tile))
      end)
    end)
  end

  test "each tile on a new board is an empty tile" do
    Enum.each(Board.new().board, fn row ->
      Enum.each(row, fn tile ->
        assert(Tile.is_empty?(tile))
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

  test "new_get_tile/2 returns a tuple with a tile at a given location" do
    board = Board.new(10, 10).board

    {:ok, tile} = Board.new_get_tile(board, {0, 0})

    assert(tile == board |> Enum.at(0) |> Enum.at(0))
  end

  test "new_get_tile/2 returns a tuple with an error if the location is out of bounds" do
    board = Board.new(10, 10).board

    response = Board.new_get_tile(board, {10, 10})

    assert(response == {:error, :out_of_bounds})
  end

  test "out_of_bounds?/2 returns false if the given location is not on the board" do
    board = Board.new().board

    assert(Board.out_of_bounds?(board, {-1, 0}) == true)
    assert(Board.out_of_bounds?(board, {0, -1}) == true)
    assert(Board.out_of_bounds?(board, {10, 0}) == true)
    assert(Board.out_of_bounds?(board, {0, 10}) == true)
  end

  test "out_of_bounds?/2 returns true if the given location is on the board" do
    board = Board.new().board

    assert(Board.out_of_bounds?(board, {0, 0}) == false)
    assert(Board.out_of_bounds?(board, {1, 1}) == false)
    assert(Board.out_of_bounds?(board, {9, 9}) == false)
  end

  test "returns a new board with a replaced tile at a given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_empty?())

    new_board = Board.replace_tile(old_board, {1, 1}, Tile.new(:bomb))

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_bomb?())
  end

  test "select_tile/2 returns a tuple with a new board with a revealed tile at the given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_hidden?())

    {:ok, new_board} = Board.select_tile(old_board, {1, 1})

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_revealed?())
  end

  test "select_tile/2 returns error data if the tile has already been revealed" do
    board =
      Board.new().board
      |> Board.reveal_tile({0, 0})

    assert(Board.select_tile(board, {0, 0}) == {:error, :already_selected})
  end

  test "flag_or_unflag_tile/2 returns a tuple with a new board with a flagged tile at the given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_hidden?())

    {:ok, new_board} = Board.flag_or_unflag_tile(old_board, {1, 1})

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_flagged?())
  end

  test "flag_or_unflag_tile/2 returns a tuple with a new board with a hidden tile if the tile was already flagged" do
    old_board =
      Board.new().board
      |> Board.flag_tile({1, 1})

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_flagged?())

    {:ok, new_board} = Board.flag_or_unflag_tile(old_board, {1, 1})

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_hidden?())
  end

  test "flag_or_unflag_tile/2 returns error data if the tile has already been revealed" do
    board =
      Board.new().board
      |> Board.reveal_tile({0, 0})

    assert(Board.flag_or_unflag_tile(board, {0, 0}) == {:error, :cannot_flag_revealed_tile})
  end

  test "takes a function that returns a new board and calls it for every tile in the board" do
    old_board = Board.new().board

    all_tiles_are_hidden? =
      Board.all_tiles(old_board)
      |> Enum.all?(&Tile.is_hidden?/1)

    assert(all_tiles_are_hidden? == true)

    new_board = Board.update_all_tiles(old_board, &reveal_tile/3)

    all_tiles_are_revealed? =
      Board.all_tiles(new_board)
      |> Enum.all?(&Tile.is_revealed?/1)

    assert(all_tiles_are_revealed? == true)
  end

  defp reveal_tile(board, tile, tile_location) do
    Board.replace_tile(board, tile_location, Tile.reveal(tile))
  end
end
