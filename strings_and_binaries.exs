defmodule StringsAndBinaries do
  def contains_all_ascii_printables([h|_]) when h < ?\s or h > ?~, do: false
  def contains_all_ascii_printables([_|t]), do: contains_all_ascii_printables(t)
  def contains_all_ascii_printables([]), do: true
  def anagram?(word1,word2), do: _anagram(prepare_words(word1) -- prepare_words(word2)) and _anagram(prepare_words(word2) -- prepare_words(word1))
  def prepare_words(words), do: words |> List.to_string |> String.replace(" ","") |> String.upcase |> String.to_charlist
  defp _anagram([]), do: true
  defp _anagram(_), do: false
  def calculate(expression) do
    case Regex.named_captures(~r/(?<first>[123456789]\d*)\s*(?<operand>[\+-\\*\/])\s*0*(?<second>[123456789]\d*)/, expression) do
      %{"first" => a, "operand" => "+", "second" => b} ->
        elem(Integer.parse(a),0) + elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "-", "second" => b} ->
        elem(Integer.parse(a),0) - elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "*", "second" => b} ->
        elem(Integer.parse(a),0) * elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "/", "second" => b} ->
        elem(Integer.parse(a),0) / elem(Integer.parse(b),0)
      %{"first" => _, "operand" => non_support, "second" => _} ->
        raise "Not supported operand '#{non_support}'"
      _ -> raise "Not parsable input"
    end
  end
end
