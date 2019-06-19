defmodule FloodFiller do
  def flood_fill(board, location) do
    tile = Board.get_tile(board, location)
    flood_fill(board, location, tile.adjacent_bomb_count)
  end

  defp flood_fill(board, _, adjacent_bomb_count) when adjacent_bomb_count > 0 do
    board
  end

  defp flood_fill(board, location, _adjacent_bomb_count) do
    board = Board.reveal_tile(board, location)

    four_way_adjacent_tile_locations(board, location)
    |> Enum.reduce(board, fn adjacent_tile_location, accumulated_board ->
      adjacent_tile = Board.get_tile(accumulated_board, adjacent_tile_location)

      if Tile.is_hidden?(adjacent_tile) do
        if adjacent_tile.adjacent_bomb_count > 0 do
          Board.reveal_tile(accumulated_board, adjacent_tile_location)
        else
          flood_fill(
            accumulated_board,
            adjacent_tile_location,
            adjacent_tile.adjacent_bomb_count
          )
        end
      else
        accumulated_board
      end
    end)
  end

  defp four_way_adjacent_tile_locations(board, {orig_row_index, orig_col_index}) do
    north_and_south_tile_locations =
      adjacent_indices(orig_row_index, Board.row_count(board))
      |> Enum.map(fn row_index ->
        {row_index, orig_col_index}
      end)

    east_and_west_tile_locations =
      adjacent_indices(orig_col_index, Board.col_count(board))
      |> Enum.map(fn col_index ->
        {orig_row_index, col_index}
      end)

    north_and_south_tile_locations ++ east_and_west_tile_locations
  end

  defp adjacent_indices(index, board_dimension) do
    [index - 1, index + 1]
    |> remove_indices_outside_of_boundaries(0, board_dimension)
  end

  defp remove_indices_outside_of_boundaries(indices, lower, upper) do
    Enum.reject(indices, fn index ->
      index < lower || index >= upper
    end)
  end
end
