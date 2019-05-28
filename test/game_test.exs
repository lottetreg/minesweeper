defmodule GameTest do
  use ExUnit.Case
  doctest Game

  import Mox

  setup :verify_on_exit!

  test "prints a 10x10 board" do
    out =
      MockOut
      |> expect(:print, 11, fn string -> send(self(), {:print, string}) end)

    Game.print_board(out)

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
