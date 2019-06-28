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

    AdjacentTileLocations.cardinal_tile_locations(board, location)
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
end
