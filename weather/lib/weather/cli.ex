defmodule Weather.CLI do
 @moduledoc """
 Handle the command line parsing and the dispatch to
 various functions that end up generating a
 table of the weather conditions for requested city using city code
 """
 def main(argv) do
   argv
   |> parse_args
   |> process
 end
 @doc """
 `argv` can be -h or --help, which returns :help.
 Otherwise it is a city code. Codes can be find at http://w1.weather.gov/xml/current_obs/
 by using state dropdown list to find all cities in that state.
 Return a tuple of `{city_code}`, or `:help`
 if help was given.
 """
 def parse_args(argv) do
   parse = OptionParser.parse(argv, switches: [help: :boolean],
   aliases: [h: :help])
   case parse do
     {[help: true],_,_} -> :help
     {_,[city_code],_} -> {city_code}
     _ -> :help
   end
 end
 def process(:help) do
   IO.puts """
   usage: weather <city_code>
   """
   System.halt(0)
 end
 def process({city_code}) do
   Weather.WeatherData.fetch(city_code)
   |> decode_response
   |> convert_to_list_of_maps
   |> Weather.TableFormatter.table_print()
 end
 def sort_into_ascending_order(list_of_issues) do
   Enum.sort list_of_issues, fn i1,i2 -> i1["created_at"] <= i2["created_at"] end
 end
 def decode_response({:ok, body}), do: body
 def decode_response({:error, error}) do
   {_,message} = List.keyfind(error,"message",0)
   IO.puts "Error fetching from Github: #{message}"
   System.halt(2)
 end
 def convert_to_list_of_maps(list) do
   list
   |> Enum.map(&Enum.into(&1, Map.new))
 end
end
