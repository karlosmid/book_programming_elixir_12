defmodule HotelRoom do
  def people do [
    %{name: 'karlo', height: 1.83},
    %{name: 'him', height: 1.63},
    %{name: 'big', height: 2.12}
    ]
  end
  def book(%{name: name, height: height})
    when height > 1.9 do
      IO.puts "Need extra long bad for #{name}"
    end
  def book(%{name: name, height: height})
    when height <1.8 do
      IO.puts "Need lower shower controls for #{name}"
    end
  def book(person) do
    IO.puts "Need regular bed for #{person.name}"
  end
end
