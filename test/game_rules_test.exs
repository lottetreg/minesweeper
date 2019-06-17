defmodule GameRulesTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "the player has lost if a bomb has been selected" do
    randomizer =
      MockRandomizer
      |> allow_random_coordinate_pair_to_return_first_row()

    tile_in_first_row = {0, 0}

    board_with_bomb_selected =
      Board.new().board
      |> BombPlacer.place_bombs(randomizer)
      |> Board.select_tile(tile_in_first_row)

    assert(GameRules.player_lost?(board_with_bomb_selected) == true)
  end

  test "the player has won if all the empty tiles have been selected" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)

    board_with_empty_tiles_selected = Board.update_all_tiles(board, &select_if_empty/3)

    assert(GameRules.player_won?(board_with_empty_tiles_selected) == true)
  end

  defp allow_random_coordinate_pair_to_return_first_row(mock_randomizer) do
    MockRandomizerHelper.allow_random_coordinate_pair_to_return(mock_randomizer)
  end

  defp select_if_empty(board, tile, tile_location) do
    if Tile.is_a?(tile, EmptyTile) do
      Board.select_tile(board, tile_location)
    else
      board
    end
  end
end
