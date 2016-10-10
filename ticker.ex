defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [nil])
    :global.register_name(@name,pid)
  end
  def register(client_pid) do
    send :global.whereis_name(@name), {:register,client_pid}
  end
  
  def generator(next) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        case next do
          nil ->
            send pid, {:next,self}
            send pid, {:tick,0}
          _ -> send pid, {:next,next}
        end
        generator(pid)
      {:tick,n} ->
        IO.puts "Tock in client #{inspect n}"
        :timer.sleep @interval
        send next, {:tick,n+1}
      generator(next)
    end
  end
end

defmodule Client do
  @interval 2000
  def start do
    pid = spawn(__MODULE__,:receiver,[nil])
    Ticker.register(pid)
  end
  def receiver(next) do
    receive do
      {:tick,n} ->
        IO.puts "Tock in client #{inspect n}"
        :timer.sleep(@interval)
        send next, {:tick,n+1}
        receiver(next)
      {:next,next} ->
        IO.puts "next is #{inspect next}"
        receiver(next)
    end
  end
end
