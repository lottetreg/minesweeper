defmodule Out do
  @behaviour OutBehaviour

  def print(string) do
    IO.puts(string)
  end
end
