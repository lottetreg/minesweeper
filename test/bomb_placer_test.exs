defmodule BombPlacerTest do
  use ExUnit.Case

  import Mox
  import MockRandomizerHelper

  setup :verify_on_exit!

  test "places 10 bombs on the board by default" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)

    number_of_bombs =
      Board.all_tiles(board)
      |> Enum.count(fn tile -> Tile.is_bomb?(tile) end)

    assert(number_of_bombs == 10)
  end

  test "places the given number of expected bombs" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer, 2)

    number_of_bombs =
      Board.all_tiles(board)
      |> Enum.count(fn tile -> Tile.is_bomb?(tile) end)

    assert(number_of_bombs == 2)
  end

  test "places bombs according to results of the Randomizer" do
    bomb_locations = [
      {0, 0},
      {1, 1},
      {2, 2},
      {3, 3},
      {4, 4},
      {5, 5},
      {6, 6},
      {7, 7},
      {8, 8},
      {9, 9}
    ]

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(bomb_locations)

    board_with_bombs =
      Board.new().board
      |> BombPlacer.place_bombs(randomizer)

    Enum.each(bomb_locations, fn bomb_location ->
      assert(Board.get_tile(board_with_bombs, bomb_location) |> Tile.is_bomb?())
    end)
  end

  test "does not place bombs on selected tiles" do
    selected_tile_location = {4, 4}
    other_tile_location = {0, 0}

    {:ok, board} =
      Board.new().board
      |> Board.select_tile(selected_tile_location)

    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return(selected_tile_location)
      |> allow_random_coordinate_pair_to_return(other_tile_location)

    board = BombPlacer.place_bombs(board, randomizer, 1)

    selected_tile = Board.get_tile(board, selected_tile_location)
    other_tile = Board.get_tile(board, other_tile_location)

    assert(Tile.is_empty?(selected_tile))
    assert(Tile.is_bomb?(other_tile))
  end
end
