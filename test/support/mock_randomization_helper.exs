defmodule MockRandomizerHelper do
  import Mox

  def allow_random_coordinate_pair_to_return(
        mock_randomizer,
        coordinate_pairs \\ first_row_coordinate_pairs()
      )

  def allow_random_coordinate_pair_to_return(
        MockRandomizer = mock_randomizer,
        [_ | _] = coordinate_pairs
      ) do
    Enum.each(coordinate_pairs, fn coordinate_pair ->
      allow_random_coordinate_pair_to_return(
        mock_randomizer,
        coordinate_pair
      )
    end)

    mock_randomizer
  end

  def allow_random_coordinate_pair_to_return(
        MockRandomizer = mock_randomizer,
        {_, _} = coordinate_pair
      ) do
    expect(mock_randomizer, :random_coordinate_pair, fn _, _ ->
      coordinate_pair
    end)

    mock_randomizer
  end

  defp first_row_coordinate_pairs do
    [
      {0, 0},
      {0, 1},
      {0, 2},
      {0, 3},
      {0, 4},
      {0, 5},
      {0, 6},
      {0, 7},
      {0, 8},
      {0, 9}
    ]
  end
end
