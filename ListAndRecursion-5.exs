defmodule ListAndRecursion do
  def all?([head|tail],func), do: if func.(head) == false, do: false, else: all?(tail,func)
  def all?([],_), do: true
end
