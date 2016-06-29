defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)
  def square([]), do: []
  def square([head|tail]), do: [head*head|square(tail)]
  def add([]), do: []
  def add([head|tail]), do: [head+1|add(tail)]
  def map([],_func), do: []
  def map([head|tail], func), do: [func.(head) | map(tail,func)]
  def sum([],total), do: total
  def sum([head|tail], total) do
    IO.puts total
    sum(tail, head+total)
  end
end
