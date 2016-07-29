defmodule FizzBuzz do
  def up_to(n) when n > 0, do: 1..n |> Enum.map(&fizz_buzz/1)
  def fizz_buzz(n) do
    case {rem(n,3),rem(n,5),n} do
      {0,0,_} -> FizzBuzz
      {0,_,_} -> Fizz
      {_,0,_} -> Buzz
      {_,_,_} -> n
    end
  end
  def ok!(input) do
    case input do
      {:ok,data} -> data
      _ -> raise "#{input}"
    end
  end
end
