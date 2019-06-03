defmodule GameState do
  defstruct [:board, :config, :status]

  def new do
    %GameState{
      board: Board.new().board,
      config: %{reader: Reader, writer: Writer},
      status: :in_progress
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
