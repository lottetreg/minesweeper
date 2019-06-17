defmodule EmptyTile do
  defstruct state: :unselected, adjacent_bomb_count: 0

  def new do
    %EmptyTile{}
  end
end
