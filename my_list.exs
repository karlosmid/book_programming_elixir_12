defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)
  def square([]), do: []
  def square([head|tail]), do: [head*head|square(tail)]
  def add([]), do: []
  def add([head|tail]), do: [head+1|add(tail)]
  def map([],_func), do: []
  def map([head|tail], func), do: [func.(head) | map(tail,func)]
  def sum(list), do: _sum(list,0)
  defp _sum([],total), do: total
  defp _sum([head|tail], total) do
    IO.puts total
    _sum(tail, head+total)
  end
  def sum_no_total([]), do: 0
  def sum_no_total([head|tail]), do: head + sum_no_total(tail)
  def reduce([],value,_), do: value
  def reduce([head|tail],value, func), do: reduce(tail, func.(head,value), func)
  def mapsum([],_), do: 0
  def mapsum([head|tail],func), do: func.(head) + mapsum(tail,func)
  def pipe_mapsum(list,func), do: list |> map(func) |> sum
  def max(list), do: _max(list,0)
  defp _max([],max_value), do: max_value
  defp _max([head|tail],max_value) when head>=max_value, do: _max(tail, head)
  defp _max([head|tail],max_value) when head<max_value, do: _max(tail, max_value)
  def wrap(letter) when rem(letter,?z)!=letter, do: ?`+rem(letter,?z)
  def wrap(letter), do: letter
  def caesar(list,chiper), do: list |> map(&(&1+chiper)) |> map(&wrap(&1))
end
