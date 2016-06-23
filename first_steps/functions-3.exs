fizz_buzz = fn
  0,0,_ -> IO.puts "FizzBuzz"
  0,_,_ -> IO.puts "Fizz"
  _,0,_ -> IO.puts "Buzz"
  a,b,c -> IO.puts c
end
enter_fizz_buzz = fn
  n -> fizz_buzz.(rem(n,3),rem(n,5),n)
end
enter_fizz_buzz.(10)
enter_fizz_buzz.(11)
enter_fizz_buzz.(12)
enter_fizz_buzz.(13)
enter_fizz_buzz.(14)
enter_fizz_buzz.(15)
enter_fizz_buzz.(16)
