defmodule GameRules do
  def player_lost?(board) do
    Board.all_tiles(board)
    |> Enum.any?(&Tile.exploded?/1)
  end

  def player_won?(board) do
    all_empty_tiles_revealed?(board) &&
      all_bomb_tiles_flagged?(board)
  end

  defp all_empty_tiles_revealed?(board) do
    Board.all_tiles(board)
    |> Enum.filter(&Tile.is_empty?/1)
    |> Enum.all?(&Tile.is_revealed?/1)
  end

  defp all_bomb_tiles_flagged?(board) do
    Board.all_tiles(board)
    |> Enum.filter(&Tile.is_bomb?/1)
    |> Enum.all?(&Tile.is_flagged?/1)
  end
end
