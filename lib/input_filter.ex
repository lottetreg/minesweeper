defmodule InputFilter do
  @exit_command "exit"

  def exit_command do
    @exit_command
  end

  def check_for_exit_command(input) do
    if input == @exit_command do
      :exit
    else
      input
    end
  end
end
