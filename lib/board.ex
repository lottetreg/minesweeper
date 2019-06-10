defmodule Board do
  defstruct [:board]

  def new do
    %Board{board: empty_board()}
  end

  def get_tile(board, {row_index, col_index}) do
    board
    |> Enum.at(row_index)
    |> Enum.at(col_index)
  end

  def select_tile(board, {row_index, col_index}) do
    List.update_at(board, row_index, fn row ->
      List.replace_at(row, col_index, :selected)
    end)
  end

  defp empty_board do
    List.duplicate(empty_row(), 10)
  end

  defp empty_row do
    List.duplicate(empty_tile(), 10)
  end

  defp empty_tile do
    :empty
  end
end
