defmodule ListAndRecursion do
  def all?([head|tail],func), do: if func.(head) == false, do: false, else: all?(tail,func)
  def all?([],_), do: true
  def each([head|tail],func), do: [func.(head)|each(tail,func)]
  def each([],_), do: []
  def filter([head|tail],func), do: if func.(head) == true, do: [head|filter(tail,func)], else: filter(tail,func)
  def filter([],_), do: []
  def split([head|tail],count), do: _split([head|tail],count,[])
  defp _split(list,count,left) when (count > 0 and count > length(list)), do: {list,left}
  defp _split(list,count,left) when (count < 0 and (count * -1) > length(list)), do: {left,list}
  defp _split(list,count,left) when count < 0, do: _split(list, length(list) + count,left)
  defp _split([head|tail],count,left) when count > 0, do: _split(tail, count - 1,[head|left])
  defp _split(list,0,left), do: {Enum.reverse(left),list}
  def take(list,n) when n < 0, do: elem split(list,n),1
  def take(list,n), do: elem split(list,n),0
end
