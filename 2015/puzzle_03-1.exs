defmodule Coordinate do
  def new(x, y) do
    {x, y}
  end

  def move({x, y}, ?^) do
    {x, y + 1}
  end
  def move({x, y}, ?>) do
    {x + 1, y}
  end
  def move({x, y}, ?v) do
    {x, y - 1}
  end
  def move({x, y}, ?<) do
    {x - 1, y}
  end
end

defmodule VisitManager do
  def visit_by_instruction(visits, current_coordinate, instruction) do
    updated_visits = Map.update(visits, Coordinate.move(current_coordinate, instruction), 1, fn existing_value -> existing_value + 1 end)
    {updated_visits, Coordinate.move(current_coordinate, instruction)}
  end
end

{:ok, instructions} = File.read("./puzzle_03_input.txt")

{visits, _} = instructions
|> String.to_charlist()
|> Enum.reduce({%{{0,0} => 1}, {0,0}}, fn instruction, {visits, at} -> VisitManager.visit_by_instruction(visits, at, instruction) end)

IO.inspect(length(Map.keys(visits)))
