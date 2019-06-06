defmodule BoardPresenter do
  @blank_space " |"

  def present(board) do
    rows_with_numbers =
      Enum.map(Enum.with_index(board), fn {row, row_number} ->
        Enum.reduce(row, "#{row_number} |", &present_tile/2) <> "\n"
      end)

    ["   A B C D E F G H I J\n", rows_with_numbers]
  end

  defp present_tile(%EmptyTile{state: :selected}, acc) do
    acc <> "X|"
  end

  defp present_tile(%EmptyTile{state: :unselected}, acc) do
    acc <> @blank_space
  end

  defp present_tile(%BombTile{state: :unselected}, acc) do
    acc <> @blank_space
  end

  defp present_tile(%BombTile{state: :selected}, acc) do
    acc <> "*|"
  end
end
