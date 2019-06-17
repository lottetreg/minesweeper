defmodule AdjacentBombCount do
  def update_adjacent_bomb_counts(board) do
    Board.update_all_tiles(board, &update_adjacent_bomb_count/3)
  end

  defp update_adjacent_bomb_count(board, tile, tile_location) do
    adjacent_bomb_count = adjacent_bomb_count(board, tile_location)
    updated_tile = Tile.update_adjacent_bomb_count(tile, adjacent_bomb_count)

    Board.replace_tile(board, tile_location, updated_tile)
  end

  defp adjacent_bomb_count(board, tile_location) do
    adjacent_tiles(board, tile_location)
    |> Enum.count(fn tile ->
      Tile.is_a?(tile, BombTile)
    end)
  end

  defp adjacent_tiles(board, tile_location) do
    adjacent_tile_locations(board, tile_location)
    |> Enum.map(fn tile_location ->
      Board.get_tile(board, tile_location)
    end)
  end

  defp adjacent_tile_locations(board, original_tile_location = {row_index, col_index}) do
    row_count = Board.row_count(board)
    col_count = Board.col_count(board)

    Enum.map(adjacent_indices(row_index, row_count), fn adjacent_row_index ->
      Enum.map(adjacent_indices(col_index, col_count), fn adjacent_col_index ->
        {adjacent_row_index, adjacent_col_index}
      end)
    end)
    |> List.flatten()
    |> Enum.reject(fn tile_location ->
      tile_location == original_tile_location
    end)
  end

  defp adjacent_indices(index, board_dimension) do
    [index - 1, index, index + 1]
    |> remove_indices_outside_of_boundaries(0, board_dimension)
  end

  defp remove_indices_outside_of_boundaries(indices, lower, upper) do
    Enum.reject(indices, fn index ->
      index < lower || index >= upper
    end)
  end
end
