defmodule MultipleProcessesExercise do
  import :timer, only: [sleep: 1]
  def greet tata do
    send(tata, "dolaze izbori!")
    raise "boom"
  end
  def run do
    spawn_monitor(MultipleProcessesExercise, :greet, [self])
    sleep 500
    collect_msg
  end
  def collect_msg do
    receive do
    msg ->
       IO.puts "Message received #{inspect msg}"
    collect_msg
    after 1000 ->
     IO.puts "This is the end"
    end
  end
end
MultipleProcessesExercise.run
