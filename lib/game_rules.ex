defmodule GameRules do
  def over?(board) do
    Board.all_tiles(board)
    |> Enum.any?(fn tile -> Tile.exploded?(tile) end)
  end
end
