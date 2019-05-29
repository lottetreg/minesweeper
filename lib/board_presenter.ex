defmodule BoardPresenter do
  def present(board) do
    rows_with_numbers =
      Enum.map(board, fn {row_number, row} ->
        Enum.reduce(row, "#{row_number} |", &present_tile/2) <> "\n"
      end)

    ["   A B C D E F G H I J\n", rows_with_numbers]
  end

  defp present_tile({_, %{selected: true}}, acc) do
    acc <> "X|"
  end

  defp present_tile({_, %{selected: false}}, acc) do
    acc <> " |"
  end
end
