defmodule InputParserTest do
  use ExUnit.Case

  test "exit_command/0 returns the string 'exit'" do
    assert(InputParser.exit_command() == "exit")
  end

  test "parse_input/1 returns {:exit, 'exit'} if the input is 'exit'" do
    assert(InputParser.parse_input("exit") == {:exit, "exit"})
  end

  test "parse_input/1 returns a tuple with :move if the input is just a number and letter" do
    assert(InputParser.parse_input("3A") == {:move, {3, 0}})
    assert(InputParser.parse_input("3a") == {:move, {3, 0}})
    assert(InputParser.parse_input(" 3A") == {:move, {3, 0}})
    assert(InputParser.parse_input("3A ") == {:move, {3, 0}})
    assert(InputParser.parse_input("33A") == {:move, {33, 0}})
    assert(InputParser.parse_input("3A 4E") == {:move, {3, 0}})
    assert(InputParser.parse_input("3A something") == {:move, {3, 0}})
    assert(InputParser.parse_input("something 3A") == {:move, {3, 0}})
  end

  test "parse_input/1 returns a :flag tuple if the input contains '-f'" do
    assert(InputParser.parse_input("3A -f") == {:flag, {3, 0}})
    assert(InputParser.parse_input("3A-f") == {:flag, {3, 0}})
    assert(InputParser.parse_input(" 3A -f") == {:flag, {3, 0}})
    assert(InputParser.parse_input("3A  -f") == {:flag, {3, 0}})
    assert(InputParser.parse_input("3A -f ") == {:flag, {3, 0}})
    assert(InputParser.parse_input("-f 3A") == {:flag, {3, 0}})
    assert(InputParser.parse_input("something -f 3A") == {:flag, {3, 0}})
    assert(InputParser.parse_input("-f 3A something") == {:flag, {3, 0}})
    assert(InputParser.parse_input("-f something 3A") == {:flag, {3, 0}})
  end

  test "parse_input/1 returns a :number tuple with the input if the input is a number" do
    assert(InputParser.parse_input("0") == {:number, 0})
    assert(InputParser.parse_input("10") == {:number, 10})
    assert(InputParser.parse_input("100") == {:number, 100})
  end

  test "parse_input/1 returns {:error, :unknown_input_type} if it does not recognise the input type" do
    assert(InputParser.parse_input("") == {:error, :unknown_input_type})
    assert(InputParser.parse_input(" ") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("1 1") == {:error, :unknown_input_type})
    assert(InputParser.parse_input(" 1") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("1 ") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("A") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("A3") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("3 A") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("3AA") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("twenty") == {:error, :unknown_input_type})
    assert(InputParser.parse_input("-f") == {:error, :unknown_input_type})
  end
end
