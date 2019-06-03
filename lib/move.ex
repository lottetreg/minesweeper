defmodule Move do
  def translate(move) do
    find_letters_and_numbers(move)
    |> build_coordinate_pair
  end

  defp find_letters_and_numbers(string) do
    Regex.scan(~r/\d+|[a-zA-Z]/, string, capture: :all)
  end

  defp build_coordinate_pair([[number], [letter]]) do
    {String.to_integer(number), alphabetical_position(letter)}
  end

  defp alphabetical_position(letter) do
    String.capitalize(letter)
    |> String.to_charlist()
    |> hd
    |> distance_from_letter_A
  end

  defp distance_from_letter_A(codepoint) do
    codepoint - ?A
  end
end
