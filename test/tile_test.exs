defmodule TileTest do
  use ExUnit.Case

  test "can only be initialized with a :bomb or :empty type" do
    Tile.new(:empty)
    Tile.new(:bomb)

    assert_raise(FunctionClauseError, fn ->
      Tile.new(:anything_else)
    end)
  end

  test "is initialized with a type" do
    assert(Tile.new(:empty).type == :empty)
    assert(Tile.new(:bomb).type == :bomb)
  end

  test "is initialized with a state of :unselected" do
    assert(Tile.new(:empty).state == :unselected)
    assert(Tile.new(:bomb).state == :unselected)
  end

  test "is initialized with an adjacent_bomb_count of 0" do
    assert(Tile.new(:empty).adjacent_bomb_count == 0)
    assert(Tile.new(:bomb).adjacent_bomb_count == 0)
  end

  test "changes the state to selected" do
    tile = new_tile()

    selected_tile = Tile.select(tile)

    assert(selected_tile.state == :selected)
  end

  test "updates the adjacent_bomb_count" do
    tile = new_tile()

    updated_tile = Tile.set_adjacent_bomb_count(tile, 1)

    assert(updated_tile.adjacent_bomb_count == 1)
  end

  test "it is exploded if it is a bomb and has been selected" do
    bomb_tile = Tile.new(:bomb)

    selected_bomb_tile = Tile.select(bomb_tile)

    assert(Tile.exploded?(selected_bomb_tile) == true)
  end

  test "it is not exploded if it is a bomb and has not been selected" do
    bomb_tile = Tile.new(:bomb)

    assert(Tile.exploded?(bomb_tile) == false)
  end

  test "it is not exploded if it is an empty tile" do
    empty_tile = Tile.new(:empty)

    assert(Tile.exploded?(empty_tile) == false)
  end

  def new_tile do
    Tile.new(:empty)
  end
end
