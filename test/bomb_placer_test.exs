defmodule BombPlacerTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "places 10 bombs on the board by default" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)

    number_of_bombs =
      Board.all_tiles(board)
      |> Enum.count(&Tile.is_bomb?/1)

    assert(number_of_bombs == 10)
  end

  test "places the given number of expected bombs" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer, 2)

    number_of_bombs =
      Board.all_tiles(board)
      |> Enum.count(&Tile.is_bomb?/1)

    assert(number_of_bombs == 2)
  end

  test "places bombs according to results of the Randomizer" do
    randomizer =
      MockRandomizer
      |> expect(:random_coordinate_pair, fn _, _ -> {0, 0} end)

    board =
      Board.new().board
      |> BombPlacer.place_bombs(randomizer, 1)

    assert(Board.get_tile(board, {0, 0}) |> Tile.is_bomb?())
  end

  test "does not place bombs on revealed tiles" do
    revealed_tile_location = {4, 4}
    unrevealed_tile_location = {0, 0}

    board =
      Board.new().board
      |> Board.reveal_tile(revealed_tile_location)

    randomizer =
      MockRandomizer
      |> expect(:random_coordinate_pair, fn _, _ -> revealed_tile_location end)
      |> expect(:random_coordinate_pair, fn _, _ -> unrevealed_tile_location end)

    board = BombPlacer.place_bombs(board, randomizer, 1)

    revealed_tile = Board.get_tile(board, revealed_tile_location)
    unrevealed_tile = Board.get_tile(board, unrevealed_tile_location)

    assert(Tile.is_empty?(revealed_tile))
    assert(Tile.is_bomb?(unrevealed_tile))
  end

  test "will place bombs on flagged tiles" do
    flagged_tile_location = {4, 4}

    board =
      Board.new().board
      |> Board.flag_tile(flagged_tile_location)

    randomizer =
      MockRandomizer
      |> expect(:random_coordinate_pair, fn _, _ -> flagged_tile_location end)

    board = BombPlacer.place_bombs(board, randomizer, 1)

    flagged_tile = Board.get_tile(board, flagged_tile_location)

    assert(Tile.is_bomb?(flagged_tile))
  end
end
