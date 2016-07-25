defmodule StringsAndBinaries do
  def contains_all_ascii_printables([h|_]) when h < ?\s or h > ?~, do: false
  def contains_all_ascii_printables([_|t]), do: contains_all_ascii_printables(t)
  def contains_all_ascii_printables([]), do: true
end
