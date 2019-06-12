defmodule Minesweeper do
  def main(_args) do
    Game.play(GameState.new())
  end
end
