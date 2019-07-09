defmodule GameStateTest do
  use ExUnit.Case

  test "is initialized with a default new board" do
    assert(GameState.new().board == NewBoard.new().board)
  end

  test "is initialized with a default config" do
    expected_default_config = %{
      reader: Reader,
      writer: Writer,
      randomizer: Randomizer
    }

    assert(GameState.new().config == expected_default_config)
  end

  test "is initialized with a default status" do
    assert(GameState.new().status == :awaiting_first_move)
  end

  test "is initialized with a default number_of_bombs" do
    assert(GameState.new().number_of_bombs == 1)
  end
end
