defmodule GameState do
  defstruct [:board, :config, :status]

  def new do
    %GameState{
      board: Board.new().board,
      config: default_config(),
      status: :awaiting_first_move
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
end
