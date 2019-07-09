defmodule GameState do
  defstruct [:board, :config, :status, :number_of_bombs]

  def new do
    %GameState{
      board: NewBoard.new().board,
      config: default_config(),
      status: :awaiting_first_move,
      number_of_bombs: 1
    }
  end

  defp default_config do
    %{
      reader: Reader,
      writer: Writer,
      randomizer: Randomizer
    }
  end

  def set_board(game_state, board) do
    %{game_state | board: board}
  end

  def set_config(game_state, config) do
    %{game_state | config: config}
  end

  def set_status(game_state, status) do
    %{game_state | status: status}
  end

  def set_number_of_bombs(game_state, number_of_bombs) do
    %{game_state | number_of_bombs: number_of_bombs}
  end
end
