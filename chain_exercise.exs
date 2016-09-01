defmodule MultiExercise do
  def echo do
    receive do
      {sender,msg} ->
        send sender, {:ok,msg}
    end
  end
  def create do
    1..2 |>
    Enum.map(fn(_x) -> spawn(MultiExercise,:echo,[]) end)
  end
  def start do
    pids = create
    msgs = [{'fred',Enum.at(pids,0)},{'betty',Enum.at(pids,1)}]
    msgs |>
    Enum.map( fn(x) -> send(elem(x,1),{self,elem(x,0)}) end)
    1..2 |>
    Enum.map(fn(_x) -> receive do
                              {_sender,msg} ->
                              IO.puts msg
                            end
                  end)
  end
end
