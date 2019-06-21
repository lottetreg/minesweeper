defmodule Minesweeper do
  def main(_args) do
    Game.start(GameState.new())
  end
end
