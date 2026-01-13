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
  def visit_by_instruction(visits, current_coordinates, instruction_index) do
    index = elem(instruction_index, 1)
    instruction = elem(instruction_index, 0)

    santas_turn = rem(index, 2) === 0
    if santas_turn do
      updated_visits = Map.update(visits, Coordinate.move(current_coordinates.santa, instruction), 1, fn existing_value -> existing_value + 1 end)
      {updated_visits, %{santa: Coordinate.move(current_coordinates.santa, instruction), robo: current_coordinates.robo}}
    else
      updated_visits = Map.update(visits, Coordinate.move(current_coordinates.robo, instruction), 1, fn existing_value -> existing_value + 1 end)
      {updated_visits, %{robo: Coordinate.move(current_coordinates.robo, instruction), santa: current_coordinates.santa}}
    end
  end
end

{:ok, instructions} = File.read("./puzzle_03_input.txt")

{visits, _} = instructions
|> String.to_charlist()
|> Enum.with_index()
|> Enum.reduce({%{{0,0} => 1}, %{santa: {0,0}, robo: {0,0}}}, fn instruction, {visits, at} -> VisitManager.visit_by_instruction(visits, at, instruction) end)

IO.inspect(length(Map.keys(visits)))
