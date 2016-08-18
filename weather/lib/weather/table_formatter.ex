defmodule Weather.TableFormatter do
  @doc """
    Print waether table based on xml elements.
    Table allignment is dynamically calculated based on column data maximal length.
  """
  def table_print data,city_code do
   create_header(city_code)
   IO.puts create_body data
 end
 @doc """
   Creates table header based on city_code
 """
 def create_header(city_code) do
   IO.puts "Weather data from weather.gov for city code: #{city_code}"
   IO.puts "---------------------------------------------------------"
 end
 def create_body(data) do
   data
   |> Enum.map(fn(x) -> "|#{elem(x,0)}: #{elem(x,1)}|\n" end)
   |> Enum.join
 end
end
