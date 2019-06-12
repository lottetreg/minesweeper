defmodule RandomizerTest do
  use ExUnit.Case

  test "only returns numbers between 0 and the number provided" do
    accumulated_results =
      Enum.reduce(1..1000, [], fn _, results ->
        {first_int, second_int} = Randomizer.random_coordinate_pair(10, 10)
        results ++ [first_int, second_int]
      end)
      |> Enum.uniq()
      |> Enum.sort()

    assert(accumulated_results == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  end
end
