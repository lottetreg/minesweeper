defmodule AdjacentBombCountTest do
  use ExUnit.Case

  test "a 3x3 board with no bombs" do
    board = Board.new(3, 3).board

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the first tile" do
    first_tile = {0, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [1, 1, 0],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the second tile" do
    second_tile = {0, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(second_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 0, 1],
             [1, 1, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the third tile" do
    third_tile = {0, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(third_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [0, 1, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the fourth tile" do
    fourth_tile = {1, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(fourth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 0],
             [0, 1, 0],
             [1, 1, 0]
           ]
  end

  test "a 3x3 board with one bomb in the fifth tile" do
    fifth_tile = {1, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(fifth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 1],
             [1, 0, 1],
             [1, 1, 1]
           ]
  end

  test "a 3x3 board with one bomb in the sixth tile" do
    sixth_tile = {1, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(sixth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 1],
             [0, 1, 0],
             [0, 1, 1]
           ]
  end

  test "a 3x3 board with one bomb in the seventh tile" do
    seventh_tile = {2, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(seventh_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [1, 1, 0],
             [0, 1, 0]
           ]
  end

  test "a 3x3 board with one bomb in the eighth tile" do
    eighth_tile = {2, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(eighth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [1, 1, 1],
             [1, 0, 1]
           ]
  end

  test "a 3x3 board with one bomb in the nineth tile" do
    nineth_tile = {2, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(nineth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [0, 1, 1],
             [0, 1, 0]
           ]
  end

  test "a 3x3 board with two bombs, in the first and second tiles" do
    first_tile = {0, 0}
    second_tile = {0, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.replace_tile(second_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 1],
             [2, 2, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with two bombs, in the first and nineth tiles" do
    first_tile = {0, 0}
    nineth_tile = {2, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.replace_tile(nineth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [1, 2, 1],
             [0, 1, 0]
           ]
  end

  defp format(board) do
    Board.update_all_tiles(board, fn board, tile, location ->
      Board.replace_tile(board, location, tile.adjacent_bomb_count)
    end)
  end
end

defmodule NewAdjacentBombCountTest do
  use ExUnit.Case

  test "a 3x3 board with no bombs" do
    board = NewBoard.new(3, 3).board

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the first tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {0, 0}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [1, 1, 0],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the second tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {0, 1}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 0, 1],
             [1, 1, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the third tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {0, 2}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [0, 1, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with one bomb in the fourth tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {1, 0}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 0],
             [0, 1, 0],
             [1, 1, 0]
           ]
  end

  test "a 3x3 board with one bomb in the fifth tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {1, 1}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 1],
             [1, 0, 1],
             [1, 1, 1]
           ]
  end

  test "a 3x3 board with one bomb in the sixth tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {1, 2}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 1],
             [0, 1, 0],
             [0, 1, 1]
           ]
  end

  test "a 3x3 board with one bomb in the seventh tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {2, 0}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [1, 1, 0],
             [0, 1, 0]
           ]
  end

  test "a 3x3 board with one bomb in the eighth tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {2, 1}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [1, 1, 1],
             [1, 0, 1]
           ]
  end

  test "a 3x3 board with one bomb in the nineth tile" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, tile} <- NewBoard.get_tile(board, {2, 2}),
           do: NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 0, 0],
             [0, 1, 1],
             [0, 1, 0]
           ]
  end

  test "a 3x3 board with two bombs, in the first and second tiles" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, first_bomb_tile} <- NewBoard.get_tile(board, {0, 0}),
           {:ok, second_bomb_tile} <- NewBoard.get_tile(board, {0, 1}),
           do:
             NewBoard.replace_tile(board, first_bomb_tile, Tile.convert_to_bomb(first_bomb_tile))
             |> NewBoard.replace_tile(second_bomb_tile, Tile.convert_to_bomb(second_bomb_tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [1, 1, 1],
             [2, 2, 1],
             [0, 0, 0]
           ]
  end

  test "a 3x3 board with two bombs, in the first and nineth tiles" do
    board =
      with board <- NewBoard.new(3, 3).board,
           {:ok, first_bomb_tile} <- NewBoard.get_tile(board, {0, 0}),
           {:ok, second_bomb_tile} <- NewBoard.get_tile(board, {2, 2}),
           do:
             NewBoard.replace_tile(board, first_bomb_tile, Tile.convert_to_bomb(first_bomb_tile))
             |> NewBoard.replace_tile(second_bomb_tile, Tile.convert_to_bomb(second_bomb_tile))

    board_with_bomb_counts = NewAdjacentBombCount.set_adjacent_bomb_counts(board)

    assert format(board_with_bomb_counts) == [
             [0, 1, 0],
             [1, 2, 1],
             [0, 1, 0]
           ]
  end

  defp format(board) do
    Enum.reduce(board, [], fn tile, list ->
      list ++ [tile.adjacent_bomb_count]
    end)
    |> Enum.chunk_every(NewBoard.col_count(board))
  end
end
