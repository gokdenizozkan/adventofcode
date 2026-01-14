defmodule Recursion do
  @secret elem(File.read("./puzzle_04_input.txt"), 1)
  def find_lowest_hash(n) do
    if :crypto.hash(:md5, @secret <> to_string(n)) |> Base.encode16(case: :lower) |> String.starts_with?("00000") do
      n
    else
      find_lowest_hash(n + 1)
    end
  end
end

result = Recursion.find_lowest_hash(0)
IO.inspect(result)
