defmodule BombPlacer do
  @total_bomb_count 10

  def place_bombs(board, randomizer, current_bomb_count \\ 0)

  def place_bombs(board, _, @total_bomb_count) do
    board
  end

  def place_bombs(board, randomizer, _current_bomb_count) do
    coordinates =
      randomizer.random_coordinate_pair(
        Board.row_count(board),
        Board.col_count(board)
      )

    board =
      if tile_is_unselected?(board, coordinates) do
        place_bomb(board, coordinates)
      else
        board
      end

    place_bombs(board, randomizer, current_bomb_count(board))
  end

  defp tile_is_unselected?(board, coordinates) do
    Board.get_tile(board, coordinates).state == :unselected
  end

  defp place_bomb(board, coordinate_pair) do
    Board.replace_tile(board, coordinate_pair, Tile.new(:bomb))
  end

  defp current_bomb_count(board) do
    Board.all_tiles(board)
    |> Enum.count(fn tile -> Tile.is_bomb?(tile) end)
  end
end
