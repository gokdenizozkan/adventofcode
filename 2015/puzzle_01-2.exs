defmodule Main do
  def process_instruction({?(, index}, acc) do
    if acc + 1 === -1 do
      IO.puts(index)
      {:halt, acc + 1}
    else
      {:cont, acc + 1}
    end
  end

  def process_instruction({?), index}, acc) do
    if acc - 1 === -1 do
      IO.puts(index)
      {:halt, acc - 1}
    else
      {:cont, acc - 1}
    end
  end
end


instructions = ""

result =
  instructions
  |> String.to_charlist()
  |> Enum.with_index(1)
  |> Enum.reduce_while(0, &Main.process_instruction/2)

IO.puts(result)
