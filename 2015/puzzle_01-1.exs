defmodule Main do
  def process_instruction(?(, acc) do
    acc + 1
  end

  def process_instruction(?), acc) do
    acc - 1
  end
end

instructions = ""

result =
  instructions
  |> String.to_charlist()
  |> Enum.reduce(0, &Main.process_instruction/2)

IO.puts(result)
