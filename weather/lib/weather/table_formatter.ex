defmodule Weather.TableFormatter do
  @doc """
    Print waether table based on xml elements.
    Table allignment is dynamically calculated based on column data maximal length.
  """
  def table_print data,city_code do
   create_name(city_code)
   IO.puts create_header data
   IO.puts create_values data
 end
 @doc """
   Creates table header based on city_code
 """
 def create_name(city_code) do
   IO.puts "Weather data from weather.gov for city code: #{city_code}"
   IO.puts "---------------------------------------------------------"
 end
 def create_header(data) do
   data
   |> Enum.map(fn(x) -> "|#{String.pad_trailing(elem(x,0),get_longer(x))}" end)
   |> Enum.join
 end
 def create_values(data) do
   data
   |> Enum.map(fn(x) -> "|#{String.pad_trailing(elem(x,1),get_longer(x))}" end)
   |> Enum.join
 end
 def get_longer column_info do
   case {String.length(elem(column_info,0)),String.length(elem(column_info,1))} do
     {_,0} -> 0
     {x,y} when x > y -> x
     {_,y} -> y
   end
 end
end
