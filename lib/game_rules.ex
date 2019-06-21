defmodule GameRules do
  def player_lost?(board) do
    Board.all_tiles(board)
    |> Enum.any?(&Tile.exploded?/1)
  end

  def player_won?(board) do
    Board.all_tiles(board)
    |> Enum.filter(&Tile.is_empty?/1)
    |> Enum.all?(&Tile.is_revealed?/1)
  end
end
