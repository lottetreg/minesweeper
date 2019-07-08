defmodule AdjacentBombCount do
  def set_adjacent_bomb_counts(board) do
    Board.update_all_tiles(board, &set_adjacent_bomb_count/3)
  end

  defp set_adjacent_bomb_count(board, tile, tile_location) do
    adjacent_bomb_count = adjacent_bomb_count(board, tile_location)
    updated_tile = Tile.set_adjacent_bomb_count(tile, adjacent_bomb_count)

    Board.replace_tile(board, tile_location, updated_tile)
  end

  defp adjacent_bomb_count(board, tile_location) do
    adjacent_tiles(board, tile_location)
    |> Enum.count(&Tile.is_bomb?/1)
  end

  defp adjacent_tiles(board, tile_location) do
    adjacent_tile_locations(board, tile_location)
    |> Enum.map(fn tile_location ->
      Board.get_tile(board, tile_location)
    end)
  end

  defp adjacent_tile_locations(board, location) do
    AdjacentTileLocations.cardinal_tile_locations(board, location) ++
      AdjacentTileLocations.ordinal_tile_locations(board, location)
  end
end

defmodule NewAdjacentBombCount do
  def set_adjacent_bomb_counts(board) do
    Board.update_all_tiles(board, &set_adjacent_bomb_count/3)
  end

  defp set_adjacent_bomb_count(board, tile, tile_location) do
    adjacent_bomb_count = adjacent_bomb_count(board, tile)
    updated_tile = Tile.set_adjacent_bomb_count(tile, adjacent_bomb_count)

    Board.replace_tile(board, tile_location, updated_tile)
  end

  defp adjacent_bomb_count(board, tile) do
    adjacent_tiles(board, tile)
    |> Enum.count(&Tile.is_bomb?/1)
  end

  defp adjacent_tiles(board, tile) do
    AdjacentTiles.cardinal_tiles(board, tile) ++
      AdjacentTiles.ordinal_tiles(board, tile)
  end
end
