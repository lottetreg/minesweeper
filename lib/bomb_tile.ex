defmodule BombTile do
  defstruct state: :unselected

  def new do
    %BombTile{}
  end
end
