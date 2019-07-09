defmodule FinalBoardPresenter do
  @blank_space " "
  @flagged_empty "X"
  @flagged_bomb "F"
  @bomb "*"
  @border "|"

  # improve this
  def present(board) do
    board = Enum.chunk_every(board, NewBoard.col_count(board))

    rows_with_numbers =
      Enum.map(Enum.with_index(board), fn {row, row_number} ->
        Enum.reduce(row, "#{row_number} |", &present_tile/2) <> "\n"
      end)

    ["   A B C D E F G H I J\n", rows_with_numbers]
  end

  defp present_tile(%Tile{state: :hidden, type: :empty}, acc) do
    acc <> @blank_space <> @border
  end

  defp present_tile(%Tile{state: :flagged, type: :empty}, acc) do
    acc <> @flagged_empty <> @border
  end

  defp present_tile(%Tile{state: :flagged, type: :bomb}, acc) do
    acc <> @flagged_bomb <> @border
  end

  defp present_tile(%Tile{state: :revealed, type: :empty} = tile, acc) do
    acc <> Integer.to_string(tile.adjacent_bomb_count) <> @border
  end

  defp present_tile(%Tile{type: :bomb}, acc) do
    acc <> @bomb <> @border
  end
end
