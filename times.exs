defmodule Times do
  def double(n) do
    n * 2
  end
  def double_one_line(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double_one_line double_one_line n
end
