defmodule StringsAndBinaries do
  def contains_all_ascii_printables([h|_]) when h < ?\s or h > ?~, do: false
  def contains_all_ascii_printables([_|t]), do: contains_all_ascii_printables(t)
  def contains_all_ascii_printables([]), do: true
  def anagram?(word1,word2), do: _anagram(:string.to_lower(word1) -- :string.to_lower(word2))
  defp _anagram([]), do: true
  defp _anagram(_), do: false
end
