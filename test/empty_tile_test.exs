defmodule EmptyTileTest do
  use ExUnit.Case

  test "changes the state to selected" do
    empty_tile = EmptyTile.new()

    assert(empty_tile.state == :unselected)

    selected_tile = Tile.select(empty_tile)

    assert(selected_tile.state == :selected)
  end

  test "it is not exploded" do
    empty_tile = EmptyTile.new()

    assert(Tile.exploded?(empty_tile) == false)
  end

  test "it knows it is an EmptyTile" do
    empty_tile = EmptyTile.new()

    assert(Tile.is_a?(empty_tile, EmptyTile) == true)
    assert(Tile.is_a?(empty_tile, BombTile) == false)
  end
end
