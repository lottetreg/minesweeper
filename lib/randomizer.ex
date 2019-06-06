defmodule Randomizer do
  @behaviour RandomizerBehaviour

  def random_coordinate_pair(row_count, col_count) do
    {random_index(row_count), random_index(col_count)}
  end

  defp random_index(number) do
    :rand.uniform(number) - 1
  end
end
