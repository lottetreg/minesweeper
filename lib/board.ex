defmodule Board do
  defstruct [:board]

  @row_count 10
  @col_count 10

  def new do
    %Board{board: empty_board()}
  end

  def row_count do
    @row_count
  end

  def col_count do
    @col_count
  end

  def all_tiles(board) do
    List.flatten(board)
  end

  def get_tile(board, {row_index, col_index}) do
    board
    |> Enum.at(row_index)
    |> Enum.at(col_index)
  end

  def select_tile(board, coordinate_pair) do
    selected_tile = get_tile(board, coordinate_pair) |> Tile.select()
    replace_tile(board, coordinate_pair, selected_tile)
  end

  def replace_tile(board, {row_index, col_index}, value) do
    List.update_at(board, row_index, fn row ->
      List.replace_at(row, col_index, value)
    end)
  end

  defp empty_board do
    List.duplicate(empty_row(), @row_count)
  end

  defp empty_row do
    List.duplicate(empty_tile(), @col_count)
  end

  defp empty_tile do
    EmptyTile.new()
  end
end
