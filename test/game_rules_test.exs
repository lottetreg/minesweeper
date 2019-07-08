defmodule GameRulesTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "the player has lost if a bomb has been revealed" do
    first_tile = {0, 0}

    board_with_bomb_revealed =
      Board.new().board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.reveal_tile(first_tile)

    assert(GameRules.player_lost?(board_with_bomb_revealed) == true)
  end

  test "the player has not lost if only empty tiles have been revealed" do
    first_tile = {0, 0}
    second_tile = {0, 1}

    board_with_empty_revealed =
      Board.new().board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.reveal_tile(second_tile)

    assert(GameRules.player_lost?(board_with_empty_revealed) == false)
  end

  test "the player has won if all the bomb tiles have been flagged and all the empty tiles have been revealed" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)
      |> Board.update_all_tiles(&reveal_if_empty/3)
      |> Board.update_all_tiles(&flag_if_bomb/3)

    assert(GameRules.player_won?(board) == true)
  end

  test "the player has not won if all the empty tiles have been not been revealed" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)
      |> Board.update_all_tiles(&flag_if_bomb/3)

    assert(GameRules.player_won?(board) == false)
  end

  test "the player has not won if all the bomb tiles have been not been flagged" do
    board =
      Board.new().board
      |> BombPlacer.place_bombs(Randomizer)
      |> Board.update_all_tiles(&reveal_if_empty/3)

    assert(GameRules.player_won?(board) == false)
  end

  defp reveal_if_empty(board, tile, tile_location) do
    if Tile.is_empty?(tile) do
      Board.reveal_tile(board, tile_location)
    else
      board
    end
  end

  defp flag_if_bomb(board, tile, tile_location) do
    if Tile.is_bomb?(tile) do
      Board.flag_tile(board, tile_location)
    else
      board
    end
  end
end
