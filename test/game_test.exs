defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "prints a 10x10 board" do
    defmodule MockOut do
      def print(string) do
        send(self(), {:print, string})
      end
    end

    Game.print_board(MockOut)

    assert_received {:print, "   A B C D E F G H I J"}
    assert_received {:print, "0 | | | | | | | | | | |"}
    assert_received {:print, "1 | | | | | | | | | | |"}
    assert_received {:print, "2 | | | | | | | | | | |"}
    assert_received {:print, "3 | | | | | | | | | | |"}
    assert_received {:print, "4 | | | | | | | | | | |"}
    assert_received {:print, "5 | | | | | | | | | | |"}
    assert_received {:print, "6 | | | | | | | | | | |"}
    assert_received {:print, "7 | | | | | | | | | | |"}
    assert_received {:print, "8 | | | | | | | | | | |"}
    assert_received {:print, "9 | | | | | | | | | | |"}
  end
end
