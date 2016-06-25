defmodule Chop do
  def guess(actual,_..b) when actual>b, do: IO.puts "You naughty hacker, your number is out of range!"
  def guess(actual,a.._) when actual<a, do: IO.puts "You naughty hacker, your number is out of range!"
  def guess(actual,a..b) when div(a+b,2)>actual do
    IO.puts "Is it #{div(a+b,2)}?"
    guess(actual,a..div(a+b,2))
  end
  def guess(actual,a..b) when div(a+b,2)<actual do
    IO.puts "Is it #{div(a+b,2)}?"
    guess(actual,div(a+b,2)+1..b)
  end
  def guess(_,a..b), do: IO.puts "It is #{div(a+b,2)}"
end
