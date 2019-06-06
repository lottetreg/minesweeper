defmodule Writer do
  @behaviour WriterBehaviour

  def write(string) do
    IO.write(string)
  end
end
