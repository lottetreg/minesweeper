defmodule Game do
  import GameHelpers

  def play(%GameState{status: :in_progress} = game_state, game_rules) do
    print_board(game_state.config.writer, game_state.board)

    move = get_move(game_state.config.reader)
    board = select_board_tile(game_state.board, move)
    game_state = GameState.set_board(game_state, board)

    play(update_status(game_state, game_rules), game_rules)
  end

  def play(%GameState{status: :over} = game_state, _) do
    print_board(game_state.config.writer, game_state.board)
  end
end
