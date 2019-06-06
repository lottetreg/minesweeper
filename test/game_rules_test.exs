defmodule GameRulesTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "a game is over if a bomb has been selected" do
    randomizer =
      MockRandomizer
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

    board =
      Board.new().board
      |> BombPlacer.place_bombs(randomizer)
      |> Board.select_tile({0, 0})

    assert(GameRules.over?(board) == true)
  end
end
