defmodule BombTileTest do
  use ExUnit.Case

  test "changes the state to selected" do
    bomb_tile = BombTile.new()

    assert(bomb_tile.state == :unselected)

    selected_tile = Tile.select(bomb_tile)

    assert(selected_tile.state == :selected)
  end

  test "it is exploded if it has been selected" do
    bomb_tile = BombTile.new()

    selected_tile = Tile.select(bomb_tile)

    assert(Tile.exploded?(selected_tile) == true)
  end

  test "it is not exploded if it has not been selected" do
    bomb_tile = BombTile.new()

    assert(Tile.exploded?(bomb_tile) == false)
  end

  test "it knows it is a BombTile" do
    bomb_tile = BombTile.new()

    assert(Tile.is_a?(bomb_tile, BombTile) == true)
    assert(Tile.is_a?(bomb_tile, EmptyTile) == false)
  end
end
