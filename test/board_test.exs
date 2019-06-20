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

  test "returns a new board with a replaced tile at a given location" do
    old_board = Board.new().board

    assert(Board.get_tile(old_board, {1, 1}) |> Tile.is_empty?())

    new_board = Board.replace_tile(old_board, {1, 1}, Tile.new(:bomb))

    assert(Board.get_tile(new_board, {1, 1}) |> Tile.is_bomb?())
  end

  test "reveals the selected tile and all of its contiguous tiles with 0 adjacent bombs" do
    board = Board.new(3, 3).board

    assert(
      format(board) == [
        [:hidden, :hidden, :hidden],
        [:hidden, :hidden, :hidden],
        [:hidden, :hidden, :hidden]
      ]
    )

    {:ok, board} = Board.select_tile(board, {0, 0})

    assert(
      format(board) == [
        [:revealed, :revealed, :revealed],
        [:revealed, :revealed, :revealed],
        [:revealed, :revealed, :revealed]
      ]
    )
  end

  test "returns error data if the tile has already been revealed" do
    board =
      Board.new().board
      |> Board.reveal_tile({0, 0})

    assert(Board.select_tile(board, {0, 0}) == {:error, :already_selected})
  end

  test "takes a function that returns a new board and calls it for every tile in the board" do
    old_board = Board.new().board

    all_tiles_are_hidden? =
      Board.all_tiles(old_board)
      |> Enum.all?(fn tile -> Tile.is_hidden?(tile) end)

    assert(all_tiles_are_hidden? == true)

    new_board = Board.update_all_tiles(old_board, &reveal_tile/3)

    all_tiles_are_revealed? =
      Board.all_tiles(new_board)
      |> Enum.all?(fn tile -> Tile.is_revealed?(tile) end)

    assert(all_tiles_are_revealed? == true)
  end

  defp reveal_tile(board, tile, tile_location) do
    Board.replace_tile(board, tile_location, Tile.reveal(tile))
  end

  defp format(board) do
    Board.update_all_tiles(board, fn board, tile, location ->
      Board.replace_tile(board, location, tile.state)
    end)
  end
end
