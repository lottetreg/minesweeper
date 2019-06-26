defmodule InputParserTest do
  use ExUnit.Case

  test "exit_command/0 returns the string 'exit'" do
    assert(InputParser.exit_command() == "exit")
  end

  test "parse_turn/1 returns {:exit, 'exit'} if the input is 'exit'" do
    assert(InputParser.parse_turn("exit") == {:exit, "exit"})
  end

  test "parse_turn/1 returns a tuple with :move if the input is just a number and letter" do
    assert(InputParser.parse_turn("3A") == {:move, {3, 0}})
    assert(InputParser.parse_turn("3a") == {:move, {3, 0}})
    assert(InputParser.parse_turn(" 3A") == {:move, {3, 0}})
    assert(InputParser.parse_turn("3A ") == {:move, {3, 0}})
    assert(InputParser.parse_turn("33A") == {:move, {33, 0}})
    assert(InputParser.parse_turn("3A 4E") == {:move, {3, 0}})
    assert(InputParser.parse_turn("3A something") == {:move, {3, 0}})
    assert(InputParser.parse_turn("something 3A") == {:move, {3, 0}})
  end

  test "parse_turn/1 returns a :flag tuple if the input contains '-f'" do
    assert(InputParser.parse_turn("3A -f") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("3A-f") == {:flag, {3, 0}})
    assert(InputParser.parse_turn(" 3A -f") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("3A  -f") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("3A -f ") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("-f 3A") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("something -f 3A") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("-f 3A something") == {:flag, {3, 0}})
    assert(InputParser.parse_turn("-f something 3A") == {:flag, {3, 0}})
  end

  test "parse_turn/1 returns {:error, :missing_letter_and_number} if the letter and number are missing" do
    assert(InputParser.parse_turn("") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn(" ") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("3 A") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("3") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("A") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("A3") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("3AA") == {:error, :missing_letter_and_number})
    assert(InputParser.parse_turn("-f") == {:error, :missing_letter_and_number})
  end

  test "parse_number/1 returns {:exit, 'exit'} if the input is 'exit'" do
    assert(InputParser.parse_number("exit") == {:exit, "exit"})
  end

  test "parse_number/1 returns a :number tuple with the input if the input is not 'exit'" do
    assert(InputParser.parse_number("something") == {:number, "something"})
  end
end
