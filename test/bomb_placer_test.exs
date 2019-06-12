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
      {1, 0},
      {2, 0},
      {3, 0},
      {4, 0},
      {5, 0},
      {6, 0},
      {7, 0},
      {8, 0},
      {9, 0}
    ]

    randomizer = MockRandomizer

    Enum.each(bomb_locations, fn bomb_location ->
      expect(randomizer, :random_coordinate_pair, fn _, _ -> bomb_location end)
    end)

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
      |> expect(:random_coordinate_pair, fn _, _ -> selected_tile_location end)
      |> expect(:random_coordinate_pair, fn _, _ -> {0, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {1, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {2, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {3, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {4, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {5, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {6, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {7, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {8, 0} end)
      |> expect(:random_coordinate_pair, fn _, _ -> {9, 0} end)

    selected_tile =
      BombPlacer.place_bombs(board, randomizer)
      |> Board.get_tile(selected_tile_location)

    assert(Tile.is_a?(selected_tile, EmptyTile))
  end
end
