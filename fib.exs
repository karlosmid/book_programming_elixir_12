defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib,n,client} ->
        send client, {:answer,fib_calc(n),self}
        fib(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end
  #very inefficient, deliberatly
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end
defmodule CatSolver do
  def cat(scheduler) do
    send scheduler, {:ready,self}
    receive do
      {:cat,file,client} ->
        send client, {:answer,file,no_of_cats(file),self}
        cat(scheduler)
      {:shutdown} -> 
        exit(:normal)
    end
  end

  def no_of_cats(file) do
    case File.dir?(file) do
      :false ->
        x = File.read!(file)
        |> String.split("cat")
        |> length
        (x - 1)
      :true -> 0
    end
  end
end
defmodule Scheduler do
  def run(num_processes,module,func,to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module,func,[self]) end)
    |> schedule_processes(to_calculate,[])
  end
  def schedule_processes(processes,queue,results) do
    receive do
      {:ready,pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {:cat, next,self}
        schedule_processes(processes,tail,results)
      {:ready,pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes,pid),queue,results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end
      {:answer, number, result, _pid} ->
        schedule_processes(processes,queue,[{number,result} | results ])
    end
  end
end

#to_process = [37,37,37,37,37,37]
to_process = File.ls!(".")

Enum.each 1..10, fn num_processes ->
  {time,result} = :timer.tc(Scheduler,:run,[num_processes,CatSolver,:cat,to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #  time (s)"
  end
  :io.format "~2B      ~.2f~n",[num_processes,time/1000000.0]
end
