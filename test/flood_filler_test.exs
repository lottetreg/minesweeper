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
