defmodule BombTile do
  defstruct state: :unselected, adjacent_bomb_count: 0

  def new do
    %BombTile{}
  end
end
