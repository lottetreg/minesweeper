defmodule Tile do
  defstruct [:row, :col, :type, :state, :adjacent_bomb_count]

  def new(_, location \\ [row: nil, col: nil])
  def new(:empty, location), do: new_with_type(:empty, location)
  def new(:bomb, location), do: new_with_type(:bomb, location)

  defp new_with_type(type, row: row, col: col) do
    %Tile{
      row: row,
      col: col,
      type: type,
      state: :hidden,
      adjacent_bomb_count: 0
    }
  end

  def reveal(tile) do
    %{tile | state: :revealed}
  end

  def flag(tile) do
    %{tile | state: :flagged}
  end

  def hide(tile) do
    %{tile | state: :hidden}
  end

  def convert_to_bomb(tile) do
    %{tile | type: :bomb}
  end

  def set_adjacent_bomb_count(tile, count) do
    %{tile | adjacent_bomb_count: count}
  end

  def exploded?(tile) do
    is_bomb?(tile) && is_revealed?(tile)
  end

  def is_empty?(tile) do
    tile.type == :empty
  end

  def is_bomb?(tile) do
    tile.type == :bomb
  end

  def is_revealed?(tile) do
    tile.state == :revealed
  end

  def is_hidden?(tile) do
    tile.state == :hidden
  end

  def is_flagged?(tile) do
    tile.state == :flagged
  end
end
