defmodule RectangularCuboid do
  def new([w, h, l]) do
    {elem(Integer.parse(w), 0), elem(Integer.parse(h), 0), elem(Integer.parse(l), 0)}
  end
  def new(l, w, h) do
    {l, w, h}
  end

  def surface_area({l, w, h}) do
    2*(l*w + l*h + w*h)
  end

  def surface_area_of_smallest_side({l, w, h}) do
    Enum.min([l * w, l * h, w * h])
  end

  def valid?({l, w, h}) do
    is_integer(l) and is_integer(w) and is_integer(h)
  end

  def shortest_distance_around_sides({l, w, h}) do
    Enum.min([2*l + 2*w, 2*l + 2*h, 2*w + 2*h])
  end

  def volume({l, w, h}) do
    l * w * h
  end
end

{:ok, input} = File.read("./puzzle_02_input.txt")
boxes = input
        |> String.split("\r\n", trim: true)
        |> Enum.map(fn content -> String.split(content, "x") end)
        |> Enum.map(&RectangularCuboid.new/1)

result = Enum.reduce(boxes, 0, fn box, acc -> acc + RectangularCuboid.shortest_distance_around_sides(box) + RectangularCuboid.volume(box)end)
IO.inspect(result)
