defmodule Tile do
  defstruct [:type, :state, :adjacent_bomb_count]

  def new(:empty), do: new_with_type(:empty)
  def new(:bomb), do: new_with_type(:bomb)

  defp new_with_type(type) do
    %Tile{
      type: type,
      state: :unselected,
      adjacent_bomb_count: 0
    }
  end

  def select(tile) do
    %{tile | state: :selected}
  end

  def set_adjacent_bomb_count(tile, count) do
    %{tile | adjacent_bomb_count: count}
  end

  def exploded?(tile) do
    is_bomb?(tile) && is_selected?(tile)
  end

  def is_empty?(tile) do
    tile.type == :empty
  end

  def is_bomb?(tile) do
    tile.type == :bomb
  end

  def is_selected?(tile) do
    tile.state == :selected
  end

  def is_unselected?(tile) do
    tile.state == :unselected
  end
end
