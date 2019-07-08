defmodule BoardPresenter do
  @blank_space " |"

  def present(board) do
    rows_with_numbers =
      Enum.map(Enum.with_index(board), fn {row, row_number} ->
        Enum.reduce(row, "#{row_number} |", &present_tile/2) <> "\n"
      end)

    ["   A B C D E F G H I J\n", rows_with_numbers]
  end

  defp present_tile(%Tile{state: :hidden}, acc) do
    acc <> @blank_space
  end

  defp present_tile(%Tile{state: :flagged}, acc) do
    acc <> "F|"
  end

  defp present_tile(%Tile{state: :revealed, type: :empty} = tile, acc) do
    acc <> Integer.to_string(tile.adjacent_bomb_count) <> "|"
  end

  defp present_tile(%Tile{state: :revealed, type: :bomb}, acc) do
    acc <> "*|"
  end
end
