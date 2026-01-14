defmodule SantaString do
  @vowels ["a", "e", "i", "o", "u"]
  @disallowed_substrings ["ab", "cd", "pq", "xy"]

  def nice?(string) do
    contains_at_least_three_vowels?(string) and a_char_appears_twice_in_a_row?(string) and not contains_disallowed_substrings?(string)
  end

  defp contains_at_least_three_vowels?(string) do
    String.count(string, @vowels) >= 3
  end

  defp a_char_appears_twice_in_a_row?(string) do
    match_index = index_of_a_char_appears_twice_in_a_row(string, 0)
    match_index !== String.length(string)
  end
  defp index_of_a_char_appears_twice_in_a_row(string, i) do
    if String.at(string, i) === String.at(string, i + 1) or String.length(string) === i do
      i
    else
      index_of_a_char_appears_twice_in_a_row(string, i + 1)
    end
  end

  defp contains_disallowed_substrings?(string) do
    String.contains?(string, @disallowed_substrings)
  end
end

result = elem(File.read("./puzzle_05_input.txt"), 1)
|> String.split("\r\n", trim: true)
|> Enum.count(&SantaString.nice?/1)

IO.inspect(result)
