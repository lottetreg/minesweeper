defmodule Minesweeper do
  def main(_args) do
    Game.play(GameState.new(), GameRules)
  end
end
