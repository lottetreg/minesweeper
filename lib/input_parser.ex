defmodule InputParser do
  @exit_command "exit"
  @flag_command "-f"

  def exit_command, do: @exit_command

  def parse_turn(input) do
    find_turn_input_type(input)
    |> parse()
  end

  def parse_number(input) do
    cond do
      is_exit_command?(input) ->
        {:exit, input}

      true ->
        {:number, input}
    end
  end

  defp find_turn_input_type(input) do
    cond do
      is_exit_command?(input) ->
        {:exit, input}

      has_flag?(input) && has_number_and_letter?(input) ->
        {:flag, input}

      has_number_and_letter?(input) ->
        {:move, input}

      true ->
        {:error, :missing_number_and_letter}
    end
  end

  defp parse({input_type, input})
       when input_type == :flag or input_type == :move do
    number_and_letter = extract_number_and_letter(input)
    {input_type, Move.translate(number_and_letter)}
  end

  defp parse({input_type, input})
       when input_type == :error or input_type == :exit do
    {input_type, input}
  end

  defp is_exit_command?(input) do
    input == @exit_command
  end

  defp has_flag?(input) do
    case capture_flag_command_from_input(input) do
      %{"flag" => _} -> true
      _ -> false
    end
  end

  defp has_number_and_letter?(input) do
    case capture_number_and_letter_from_input(input) do
      %{"number_and_letter" => _} -> true
      _ -> false
    end
  end

  defp extract_number_and_letter(input) do
    capture_number_and_letter_from_input(input)["number_and_letter"]
  end

  defp capture_flag_command_from_input(input) do
    Regex.named_captures(~r/.*(?<flag>#{@flag_command})/, input)
  end

  defp capture_number_and_letter_from_input(input) do
    Regex.named_captures(~r/\D*(?<number_and_letter>\d+[a-zA-Z]{1})\b/, input)
  end
end
