defmodule GameStateTest do
  use ExUnit.Case

  test "is initialized with a default new board" do
    assert(GameState.new().board == Board.new().board)
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
end
