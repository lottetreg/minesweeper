defmodule BombPlacer do
  def place_bombs(board, randomizer, expected_bomb_count \\ 10) do
    place_bombs(board, randomizer, expected_bomb_count, 0)
  end

  defp place_bombs(board, _, expected_bomb_count, bomb_count)
       when bomb_count == expected_bomb_count do
    board
  end

  defp place_bombs(board, randomizer, expected_bomb_count, _current_bomb_count) do
    coordinates =
      randomizer.random_coordinate_pair(
        Board.row_count(board),
        Board.col_count(board)
      )

    board =
      if tile_is_revealed?(board, coordinates) do
        board
      else
        place_bomb(board, coordinates)
      end

    place_bombs(
      board,
      randomizer,
      expected_bomb_count,
      current_bomb_count(board)
    )
  end

  defp tile_is_revealed?(board, coordinates) do
    Board.get_tile(board, coordinates)
    |> Tile.is_revealed?()
  end

  defp place_bomb(board, coordinate_pair) do
    tile = Board.get_tile(board, coordinate_pair)
    Board.replace_tile(board, coordinate_pair, Tile.convert_to_bomb(tile))
  end

  defp current_bomb_count(board) do
    Board.all_tiles(board)
    |> Enum.count(&Tile.is_bomb?/1)
  end
end
