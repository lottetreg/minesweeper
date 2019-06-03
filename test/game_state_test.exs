defmodule GameStateTest do
  use ExUnit.Case

  test "is initialized with a default new board" do
    assert(GameState.new().board == Board.new().board)
  end

  test "is initialized with a default config" do
    assert(GameState.new().config == %{reader: Reader, writer: Writer})
  end

  test "is initialized with a default status" do
    assert(GameState.new().status == :in_progress)
  end
end
