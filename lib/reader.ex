defmodule Reader do
  @behaviour ReaderBehaviour

  def read do
    IO.read(:line)
    |> String.trim()
  end
end
