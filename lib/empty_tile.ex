defmodule EmptyTile do
  defstruct state: :unselected

  def new do
    %EmptyTile{}
  end
end
