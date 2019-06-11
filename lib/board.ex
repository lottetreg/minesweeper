defmodule Board do
  defstruct [:board]

  def new(row_count \\ 10, col_count \\ 10) do
    %Board{
      board: empty_board(row_count, col_count)
    }
  end

  def row_count(board) do
    length(board)
  end

  def col_count(board) do
    first_row = Enum.at(board, 0)
    length(first_row)
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

  def update_all_tiles(board, func) do
    Enum.reduce(Enum.with_index(board), board, fn {row, row_index}, board ->
      Enum.reduce(Enum.with_index(row), board, fn {tile, col_index}, board ->
        func.(board, tile, {row_index, col_index})
      end)
    end)
  end

  defp empty_board(row_count, col_count) do
    List.duplicate(empty_row(col_count), row_count)
  end

  defp empty_row(col_count) do
    List.duplicate(empty_tile(), col_count)
  end

  defp empty_tile do
    EmptyTile.new()
  end
end
