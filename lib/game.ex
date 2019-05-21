defmodule Game do
  @doc ~S"""
  Prints a 10x10 board with row and column headers
  """
  def print_board(out) do
    out.print("   A B C D E F G H I J")
    Enum.each(0..9, fn x -> out.print("#{x} | | | | | | | | | | |") end)
  end
end
