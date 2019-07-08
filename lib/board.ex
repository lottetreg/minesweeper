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

  # remove
  def get_tile(board, {row_index, col_index}) do
    board
    |> Enum.at(row_index)
    |> Enum.at(col_index)
  end

  def new_get_tile(board, {row_index, col_index}) do
    if out_of_bounds?(board, {row_index, col_index}) do
      {:error, :out_of_bounds}
    else
      tile =
        board
        |> Enum.at(row_index)
        |> Enum.at(col_index)

      {:ok, tile}
    end
  end

  def flag_or_unflag_tile(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair),
         do: flag_or_unflag_tile(board, tile, coordinate_pair)
  end

  def select_tile(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair),
         do: select_tile(board, tile, coordinate_pair)
  end

  def select_tile_with_floodfill(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair),
         do: select_tile_with_floodfill(board, tile, coordinate_pair)
  end

  defp flag_or_unflag_tile(board, tile, coordinate_pair) do
    cond do
      Tile.is_revealed?(tile) ->
        {:error, :cannot_flag_revealed_tile}

      Tile.is_flagged?(tile) ->
        board = hide_tile(board, coordinate_pair)

        {:ok, board}

      !Tile.is_flagged?(tile) ->
        board = flag_tile(board, coordinate_pair)

        {:ok, board}
    end
  end

  defp select_tile(board, tile, coordinate_pair) do
    if Tile.is_revealed?(tile) do
      {:error, :already_selected}
    else
      board = reveal_tile(board, coordinate_pair)

      {:ok, board}
    end
  end

  defp select_tile_with_floodfill(board, tile, coordinate_pair) do
    if Tile.is_revealed?(tile) do
      {:error, :already_selected}
    else
      board =
        reveal_tile(board, coordinate_pair)
        |> FloodFiller.flood_fill(coordinate_pair)

      {:ok, board}
    end
  end

  # uggghhh want to have coordinates ON tiles, then just pass tile into here instead of coordinate_pair
  def flag_tile(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair) do
      replace_tile(board, coordinate_pair, Tile.flag(tile))
    end
  end

  def hide_tile(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair) do
      replace_tile(board, coordinate_pair, Tile.hide(tile))
    end
  end

  def reveal_tile(board, coordinate_pair) do
    with {:ok, tile} <- new_get_tile(board, coordinate_pair) do
      replace_tile(board, coordinate_pair, Tile.reveal(tile))
    end
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

  def out_of_bounds?(board, {row_index, col_index}) do
    row_out_of_bounds?(board, row_index) ||
      col_out_of_bounds?(board, col_index)
  end

  defp empty_board(row_count, col_count) do
    List.duplicate(empty_row(col_count), row_count)
  end

  defp empty_row(col_count) do
    List.duplicate(empty_tile(), col_count)
  end

  defp empty_tile do
    Tile.new(:empty)
  end

  defp row_out_of_bounds?(board, row_index) do
    row_index < 0 || row_index >= Board.row_count(board)
  end

  defp col_out_of_bounds?(board, col_index) do
    col_index < 0 || col_index >= Board.col_count(board)
  end
end

defmodule NewBoard do
  # remove struct later
  defstruct [:board]

  def new(row_count \\ 10, col_count \\ 10) do
    %Board{
      board: empty_board(row_count, col_count)
    }
  end

  def row_count(board) do
    Enum.uniq_by(board, & &1.row)
    |> Enum.count()
  end

  def col_count(board) do
    Enum.uniq_by(board, & &1.col)
    |> Enum.count()
  end

  # remove
  def all_tiles(board) do
    board
  end

  def get_tile(board, {row, col}) do
    tile = Enum.find(board, &(&1.row == row && &1.col == col))

    if tile do
      {:ok, tile}
    else
      {:error, :out_of_bounds}
    end
  end

  def select_tile(board, location) do
    with {:ok, tile} <- get_tile(board, location) do
      if Tile.is_revealed?(tile) do
        {:error, :already_selected}
      else
        {:ok, reveal_tile(board, tile)}
      end
    end
  end

  def select_tile_with_floodfill(board, location) do
    with {:ok, tile} <- get_tile(board, location) do
      if Tile.is_revealed?(tile) do
        {:error, :already_selected}
      else
        board =
          reveal_tile(board, tile)
          |> NewFloodFiller.flood_fill(tile)

        {:ok, board}
      end
    end
  end

  # rename flag_tile?
  def flag_or_unflag_tile(board, location) do
    with {:ok, tile} <- get_tile(board, location) do
      cond do
        Tile.is_revealed?(tile) ->
          {:error, :cannot_flag_revealed_tile}

        Tile.is_flagged?(tile) ->
          {:ok, hide_tile(board, tile)}

        !Tile.is_flagged?(tile) ->
          {:ok, flag_tile(board, tile)}
      end
    end
  end

  # make private or remove?
  def flag_tile(board, tile) do
    replace_tile(board, tile, Tile.flag(tile))
  end

  # make private or remove?
  def hide_tile(board, tile) do
    replace_tile(board, tile, Tile.hide(tile))
  end

  # make private or remove?
  def reveal_tile(board, tile) do
    replace_tile(board, tile, Tile.reveal(tile))
  end

  def replace_tile(board, orig_tile, replacement_tile) do
    tile_index =
      Enum.find_index(board, fn tile ->
        tile.row == orig_tile.row && tile.col == orig_tile.col
      end)

    List.replace_at(board, tile_index, replacement_tile)
  end

  def update_all_tiles(board, func) do
    Enum.reduce(board, board, fn tile, board ->
      func.(board, tile)
    end)
  end

  defp empty_board(row_count, col_count) do
    Enum.reduce(0..(row_count - 1), [], fn row, list ->
      Enum.reduce(0..(col_count - 1), list, fn col, list ->
        list ++ [Tile.new(:empty, row: row, col: col)]
      end)
    end)
  end
end
