defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name,pid)
  end
  def register(client_pid) do
    send :global.whereis_name(@name), {:register,client_pid}
  end
  
  def do_round_robin_tick(list,len) when len > 0, do: send_and_round(list)
  def do_round_robin_tick(list,len) when len == 0, do: []
  
  
  def send_and_round(list) do
    send Enum.at(list,0), {:tick}
    round_robin(list)
  end

  def round_robin list do
    [head|tail] = list
    tail ++ [head]
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"
        clients = do_round_robin_tick(clients,length(clients))
        IO.puts "#{inspect clients}"
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__,:receiver,[])
    Ticker.register(pid)
  end
  def receiver do
    receive do
      {:tick} ->
        IO.puts "Tock in client"
        receiver
    end
  end
end
