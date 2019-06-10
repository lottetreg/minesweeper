defmodule MoveTest do
  use ExUnit.Case

  test "translates a number and letter pair to a coordinate pair" do
    assert(Move.translate("0A") == {0, 0})
    assert(Move.translate("0B") == {0, 1})
    assert(Move.translate("1A") == {1, 0})
    assert(Move.translate("1B") == {1, 1})
  end

  test "raises an ArgumentError if the letter comes before the number" do
    assert_raise(ArgumentError, fn ->
      Move.translate("A0")
    end)
  end

  test "raises a FunctionClauseError if there are two letters and a number" do
    assert_raise(FunctionClauseError, fn ->
      Move.translate("0AB")
    end)
  end
end
