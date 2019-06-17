defmodule GameRules do
  def player_lost?(board) do
    Board.all_tiles(board)
    |> Enum.any?(fn tile -> Tile.exploded?(tile) end)
  end

  def player_won?(board) do
    Board.all_tiles(board)
    |> Enum.filter(fn tile -> Tile.is_empty?(tile) end)
    |> Enum.all?(fn empty_tile -> Tile.is_selected?(empty_tile) end)
  end
end
