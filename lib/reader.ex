defmodule Reader do
  @behaviour ReaderBehaviour

  def read do
    IO.read(:line)
  end
end
