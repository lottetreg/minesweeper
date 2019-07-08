defmodule FloodFillerTest do
  use ExUnit.Case

  test "all tiles with 0 adjacent bombs that are contiguous to the initial tile are revealed" do
    board =
      Board.new(3, 3).board
      |> Board.reveal_tile({0, 0})

    flood_filled_board = FloodFiller.flood_fill(board, {0, 0})

    assert format(flood_filled_board) == [
             ["0", "0", "0"],
             ["0", "0", "0"],
             ["0", "0", "0"]
           ]
  end

  test "all contiguous tiles with 0 adjacent bombs are revealed, even if the initial tile has not been revealed yet" do
    board = Board.new(3, 3).board

    flood_filled_board = FloodFiller.flood_fill(board, {0, 0})

    assert format(flood_filled_board) == [
             ["0", "0", "0"],
             ["0", "0", "0"],
             ["0", "0", "0"]
           ]
  end

  test "does not reveal contiguous tiles with 0 adjacent bombs if the initial tile has an adjacent bomb" do
    board =
      Board.new(3, 3).board
      |> Board.replace_tile({0, 0}, Tile.new(:bomb))
      |> AdjacentBombCount.set_adjacent_bomb_counts()
      |> Board.reveal_tile({0, 1})

    flood_filled_board = FloodFiller.flood_fill(board, {0, 1})

    assert format(flood_filled_board) == [
             ["B", "1", "?"],
             ["?", "?", "?"],
             ["?", "?", "?"]
           ]
  end

  test "reveals the tiles with adjacent bombs that border the contiguous tiles with 0 adjacent bombs" do
    board =
      Board.new(3, 3).board
      |> Board.replace_tile({0, 0}, Tile.new(:bomb))
      |> AdjacentBombCount.set_adjacent_bomb_counts()
      |> Board.reveal_tile({0, 2})

    flood_filled_board = FloodFiller.flood_fill(board, {0, 2})

    assert format(flood_filled_board) == [
             ["B", "1", "0"],
             ["1", "1", "0"],
             ["0", "0", "0"]
           ]
  end

  test "reveals contiguous tiles with 0 adjacent bombs on a small, non-square board" do
    board =
      Board.new(1, 4).board
      |> Board.replace_tile({0, 0}, Tile.new(:bomb))
      |> AdjacentBombCount.set_adjacent_bomb_counts()
      |> Board.reveal_tile({0, 2})

    flood_filled_board = FloodFiller.flood_fill(board, {0, 2})

    assert format(flood_filled_board) == [
             ["B", "1", "0", "0"]
           ]
  end

  test "reveals contiguous tiles with 0 adjacent bombs for a very squiggly set of continuous squares" do
    board =
      Board.new(6, 6).board
      |> Board.replace_tile({0, 0}, Tile.new(:bomb))
      |> Board.replace_tile({1, 3}, Tile.new(:bomb))
      |> Board.replace_tile({5, 2}, Tile.new(:bomb))
      |> AdjacentBombCount.set_adjacent_bomb_counts()
      |> Board.reveal_tile({0, 5})

    flood_filled_board = FloodFiller.flood_fill(board, {0, 5})

    assert format(flood_filled_board) == [
             ["B", "?", "?", "?", "1", "0"],
             ["1", "1", "?", "B", "1", "0"],
             ["0", "0", "1", "1", "1", "0"],
             ["0", "0", "0", "0", "0", "0"],
             ["0", "1", "1", "1", "0", "0"],
             ["0", "1", "B", "1", "0", "0"]
           ]
  end

  defp format(board) do
    Board.update_all_tiles(board, fn board, tile, location ->
      cond do
        Tile.is_bomb?(tile) ->
          Board.replace_tile(board, location, "B")

        Tile.is_revealed?(tile) ->
          bomb_count = Integer.to_string(tile.adjacent_bomb_count)
          Board.replace_tile(board, location, bomb_count)

        true ->
          Board.replace_tile(board, location, "?")
      end
    end)
  end
end

defmodule NewFloodFillerTest do
  use ExUnit.Case

  test "all tiles with 0 adjacent bombs that are contiguous to the initial tile are revealed" do
    board = NewBoard.new(3, 3).board

    {:ok, tile} = NewBoard.get_tile(board, {0, 0})

    flood_filled_board = NewFloodFiller.flood_fill(board, tile)

    assert format(flood_filled_board) == [
             ["0", "0", "0"],
             ["0", "0", "0"],
             ["0", "0", "0"]
           ]
  end

  test "all contiguous tiles with 0 adjacent bombs are revealed, even if the initial tile has not been revealed yet" do
    board = NewBoard.new(3, 3).board

    {:ok, tile} = NewBoard.get_tile(board, {0, 0})

    flood_filled_board = NewFloodFiller.flood_fill(board, tile)

    assert format(flood_filled_board) == [
             ["0", "0", "0"],
             ["0", "0", "0"],
             ["0", "0", "0"]
           ]
  end

  test "does not reveal contiguous tiles with 0 adjacent bombs if the initial tile has an adjacent bomb" do
    board = NewBoard.new(3, 3).board

    board_with_bomb =
      with {:ok, tile} <- NewBoard.get_tile(board, {0, 0}) do
        NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))
        |> NewAdjacentBombCount.set_adjacent_bomb_counts()
      end

    flood_filled_board =
      with {:ok, tile} <- NewBoard.get_tile(board_with_bomb, {0, 1}) do
        NewBoard.reveal_tile(board_with_bomb, tile)
        |> NewFloodFiller.flood_fill(tile)
      end

    assert format(flood_filled_board) == [
             ["B", "1", "?"],
             ["?", "?", "?"],
             ["?", "?", "?"]
           ]
  end

  test "reveals the tiles with adjacent bombs that border the contiguous tiles with 0 adjacent bombs" do
    board = NewBoard.new(3, 3).board

    board_with_bomb =
      with {:ok, tile} <- NewBoard.get_tile(board, {0, 0}) do
        NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))
        |> NewAdjacentBombCount.set_adjacent_bomb_counts()
      end

    flood_filled_board =
      with {:ok, tile} <- NewBoard.get_tile(board_with_bomb, {0, 2}) do
        NewBoard.reveal_tile(board_with_bomb, tile)
        |> NewFloodFiller.flood_fill(tile)
      end

    assert format(flood_filled_board) == [
             ["B", "1", "0"],
             ["1", "1", "0"],
             ["0", "0", "0"]
           ]
  end

  test "reveals contiguous tiles with 0 adjacent bombs on a small, non-square board" do
    board = NewBoard.new(1, 4).board

    board_with_bomb =
      with {:ok, tile} <- NewBoard.get_tile(board, {0, 0}) do
        NewBoard.replace_tile(board, tile, Tile.convert_to_bomb(tile))
        |> NewAdjacentBombCount.set_adjacent_bomb_counts()
      end

    flood_filled_board =
      with {:ok, tile} <- NewBoard.get_tile(board_with_bomb, {0, 2}) do
        NewBoard.reveal_tile(board_with_bomb, tile)
        |> NewFloodFiller.flood_fill(tile)
      end

    assert format(flood_filled_board) == [
             ["B", "1", "0", "0"]
           ]
  end

  test "reveals contiguous tiles with 0 adjacent bombs for a very squiggly set of continuous squares" do
    board = NewBoard.new(6, 6).board

    board_with_bombs =
      with {:ok, first_bomb} <- NewBoard.get_tile(board, {0, 0}),
           {:ok, second_bomb} <- NewBoard.get_tile(board, {1, 3}),
           {:ok, third_bomb} <- NewBoard.get_tile(board, {5, 2}) do
        NewBoard.replace_tile(board, first_bomb, Tile.convert_to_bomb(first_bomb))
        |> NewBoard.replace_tile(second_bomb, Tile.convert_to_bomb(second_bomb))
        |> NewBoard.replace_tile(third_bomb, Tile.convert_to_bomb(third_bomb))
        |> NewAdjacentBombCount.set_adjacent_bomb_counts()
      end

    flood_filled_board =
      with {:ok, tile} <- NewBoard.get_tile(board_with_bombs, {0, 5}) do
        NewBoard.reveal_tile(board_with_bombs, tile)
        |> NewFloodFiller.flood_fill(tile)
      end

    assert format(flood_filled_board) == [
             ["B", "?", "?", "?", "1", "0"],
             ["1", "1", "?", "B", "1", "0"],
             ["0", "0", "1", "1", "1", "0"],
             ["0", "0", "0", "0", "0", "0"],
             ["0", "1", "1", "1", "0", "0"],
             ["0", "1", "B", "1", "0", "0"]
           ]
  end

  defp format(board) do
    Enum.reduce(board, [], fn tile, list ->
      cond do
        Tile.is_bomb?(tile) ->
          list ++ ["B"]

        Tile.is_revealed?(tile) ->
          bomb_count = Integer.to_string(tile.adjacent_bomb_count)
          list ++ [bomb_count]

        true ->
          list ++ ["?"]
      end
    end)
    |> Enum.chunk_every(NewBoard.col_count(board))
  end
end
