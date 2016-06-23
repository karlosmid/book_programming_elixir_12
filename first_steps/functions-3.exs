fizz_buzz = fn
  0,0,_ -> "FizzBuzz"
  0,_,_ -> "Fizz"
  _,0,_ -> "Buzz"
  _,_,c -> c
end
enter_fizz_buzz = fn
  n -> fizz_buzz.(rem(n,3),rem(n,5),n)
end
IO.inspect Enum.map(10..16,enter_fizz_buzz)
