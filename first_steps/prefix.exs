prefix = fn input_1 -> (fn input_2 -> "#{input_1} #{input_2}" end)end
mrs = prefix.("Mrs")
IO.puts mrs.("Kolinda")
IO.puts prefix.("Elixir").("Rocks")
