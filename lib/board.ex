defmodule Board do
  defstruct [:board]

  def new do
    %Board{board: empty_board()}
  end

  defp empty_board do
    %{
      0 => empty_row(),
      1 => empty_row(),
      2 => empty_row(),
      3 => empty_row(),
      4 => empty_row(),
      5 => empty_row(),
      6 => empty_row(),
      7 => empty_row(),
      8 => empty_row(),
      9 => empty_row()
    }
  end

  defp empty_row do
    %{
      0 => empty_tile(),
      1 => empty_tile(),
      2 => empty_tile(),
      3 => empty_tile(),
      4 => empty_tile(),
      5 => empty_tile(),
      6 => empty_tile(),
      7 => empty_tile(),
      8 => empty_tile(),
      9 => empty_tile()
    }
  end

  defp empty_tile do
    %{selected: false}
  end
end
