defmodule Game do
  def print_board(writer, board) do
    writer.write(BoardPresenter.present(board))
  end

  def get_move(reader) do
    reader.read
    |> find_letters_and_numbers
    |> build_coordinate_pair
  end

  def select_board_tile(board, {x, y}) do
    put_in(board[x][y].selected, true)
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
