defmodule BombPlacerTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "places exactly 10 bombs on the board" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)

    number_of_bombs =
      Board.all_tiles(board)
      |> Enum.count(fn tile -> Tile.is_a?(tile, BombTile) end)

    assert(number_of_bombs == 10)
  end

  test "places 10 bombs according to results of the Randomizer" do
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
      |> MockRandomizerHelper.allow_random_coordinate_pair_to_return(bomb_locations)

    board_with_bombs =
      Board.new().board
      |> BombPlacer.place_bombs(randomizer)

    Enum.each(bomb_locations, fn bomb_location ->
      assert(Board.get_tile(board_with_bombs, bomb_location) |> Tile.is_a?(BombTile))
    end)
  end

  test "does not place bombs on selected tiles" do
    selected_tile_location = {4, 4}

    board =
      Board.new().board
      |> Board.select_tile(selected_tile_location)

    randomizer =
      MockRandomizer
      |> MockRandomizerHelper.allow_random_coordinate_pair_to_return(selected_tile_location)
      |> MockRandomizerHelper.allow_random_coordinate_pair_to_return()

    board = BombPlacer.place_bombs(board, randomizer)

    selected_tile = Board.get_tile(board, selected_tile_location)

    assert(Tile.is_a?(selected_tile, EmptyTile))
  end
end
