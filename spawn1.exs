defmodule Spawn1 do
  def greet do
    receive do
      {sender,msg} ->
        send sender, {:ok, "Hello #{msg}"}
        greet
    end
  end
end

pid = spawn(Spawn1, :greet, [])
send pid, {self, "Karlo"}

receive do
  {sender, msg} ->
    IO.puts msg
end

send pid, {self, "Takujin"}

receive do
  {sender, msg} ->
    IO.puts msg
  after 550 ->
    IO.puts "The greeter has gone away!"
end
