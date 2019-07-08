defmodule AdjacentTileLocations do
  def cardinal_tile_locations(board, location) do
    [
      north_tile_location(location),
      south_tile_location(location),
      east_tile_location(location),
      west_tile_location(location)
    ]
    |> remove_out_of_bounds_locations(board)
  end

  def ordinal_tile_locations(board, location) do
    [
      north_east_tile_location(location),
      north_west_tile_location(location),
      south_east_tile_location(location),
      south_west_tile_location(location)
    ]
    |> remove_out_of_bounds_locations(board)
  end

  defp north_tile_location({row_index, col_index}) do
    {row_index - 1, col_index}
  end

  defp south_tile_location({row_index, col_index}) do
    {row_index + 1, col_index}
  end

  defp east_tile_location({row_index, col_index}) do
    {row_index, col_index + 1}
  end

  defp west_tile_location({row_index, col_index}) do
    {row_index, col_index - 1}
  end

  defp north_east_tile_location({row_index, col_index}) do
    {row_index - 1, col_index + 1}
  end

  defp north_west_tile_location({row_index, col_index}) do
    {row_index - 1, col_index - 1}
  end

  defp south_east_tile_location({row_index, col_index}) do
    {row_index + 1, col_index + 1}
  end

  defp south_west_tile_location({row_index, col_index}) do
    {row_index + 1, col_index - 1}
  end

  defp remove_out_of_bounds_locations(tile_locations, board) do
    Enum.reject(tile_locations, fn tile_location ->
      Board.out_of_bounds?(board, tile_location)
    end)
  end
end

defmodule AdjacentTiles do
  def cardinal_tiles(board, tile) do
    [
      north_tile_location(tile),
      south_tile_location(tile),
      east_tile_location(tile),
      west_tile_location(tile)
    ]
    |> get_tiles(board)
  end

  def ordinal_tiles(board, tile) do
    [
      north_east_tile_location(tile),
      north_west_tile_location(tile),
      south_east_tile_location(tile),
      south_west_tile_location(tile)
    ]
    |> get_tiles(board)
  end

  defp north_tile_location(tile) do
    {tile.row - 1, tile.col}
  end

  defp south_tile_location(tile) do
    {tile.row + 1, tile.col}
  end

  defp east_tile_location(tile) do
    {tile.row, tile.col + 1}
  end

  defp west_tile_location(tile) do
    {tile.row, tile.col - 1}
  end

  defp north_east_tile_location(tile) do
    {tile.row - 1, tile.col + 1}
  end

  defp north_west_tile_location(tile) do
    {tile.row - 1, tile.col - 1}
  end

  defp south_east_tile_location(tile) do
    {tile.row + 1, tile.col + 1}
  end

  defp south_west_tile_location(tile) do
    {tile.row + 1, tile.col - 1}
  end

  defp get_tiles(tile_locations, board) do
    Enum.flat_map(tile_locations, fn tile_location ->
      case NewBoard.get_tile(board, tile_location) do
        {:ok, tile} -> [tile]
        {:error, :out_of_bounds} -> []
      end
    end)
  end
end
