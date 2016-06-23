fizz_buzz = fn
  0,0,_ -> IO.puts "FizzBuzz"
  0,_,_ -> IO.puts "Fizz"
  _,0,_ -> IO.puts "Buzz"
  a,b,c -> IO.puts c
end
IO.puts fizz_buzz.(0,0,1)
IO.puts fizz_buzz.(0,1,1)
IO.puts fizz_buzz.(1,0,1)
IO.puts fizz_buzz.(1,1,3)
