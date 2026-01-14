defmodule SantaString do
  def nice?(string) do
    any_repeating_pattern = %{}
    |> scan_pairs(string, 0)
    |> Map.keys()
    |> Enum.map(fn pair -> count_pair_occurences(string, pair, 0, 0) end)
    |> Enum.any?(fn occurence -> occurence > 1 end)

    any_repeating_pattern and has_mirrored_char?(string)
  end

  defp scan_pairs(pairs, string, i) do
    if (String.length(string) - 1 === i) do
      pairs
    else
      scan_pairs(Map.put(pairs, String.at(string, i) <> String.at(string, i + 1), 0), string, i + 1)
    end
  end

  defp count_pair_occurences(string, pair, i, count) do
    if i + 1 === String.length(string) do
      count
    else
      if String.at(string, i) <> String.at(string, i + 1) === pair do
        if (i + 2 >= String.length(string)) do
          count + 1
        else
          count_pair_occurences(String.slice(string, i + 2..String.length(string)), pair, 0, count + 1)
        end
      else
        count_pair_occurences(string, pair, i + 1, count)
      end
    end
  end

  defp has_mirrored_char?(string) do
    match_index = mirrored_char_index(string, 0)
    match_index + 1 !== String.length(string)
  end
  defp mirrored_char_index(string, i) do
    if i + 1 === String.length(string) or String.at(string, i) === String.at(string, i + 2) do
      i
    else
      mirrored_char_index(string, i + 1)
    end
  end
end

result = elem(File.read("./puzzle_05_input.txt"), 1)
|> String.split("\r\n", trim: true)
|> Enum.count(&SantaString.nice?/1)
IO.inspect(result)
