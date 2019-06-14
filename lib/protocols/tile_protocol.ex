defprotocol Tile do
  def select(tile)
  def exploded?(tile)
  def is_a?(tile, module_name)
  def update_adjacent_bomb_count(tile, count)
end

defimpl Tile, for: EmptyTile do
  def select(tile) do
    %{tile | state: :selected}
  end

  def exploded?(_tile) do
    false
  end

  def is_a?(_tile, module_name) do
    module_name == EmptyTile
  end

  def update_adjacent_bomb_count(tile, count) do
    %{tile | adjacent_bomb_count: count}
  end
end

defimpl Tile, for: BombTile do
  def select(tile) do
    %{tile | state: :selected}
  end

  def exploded?(tile) do
    tile.state == :selected
  end

  def is_a?(_tile, module_name) do
    module_name == BombTile
  end

  def update_adjacent_bomb_count(tile, count) do
    %{tile | adjacent_bomb_count: count}
  end
end
