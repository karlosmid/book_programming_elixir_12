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
   |> Weather.FlatXmlParser.convert_xml_to_list(Enum.take(elements,5))
   |> Weather.TableFormatter.table_print(city_code)
 end
 def decode_response({:ok, body}), do: body
 def decode_response({:error, error}) do
   {_,message} = List.keyfind(error,"message",0)
   IO.puts "Error fetching from weather site: #{message}"
   System.halt(2)
 end
 def elements do
   ["credit","credit_URL","suggested_pickup","suggested_pickup_period","location","station_id","latitude",
	"longitude","observation_time","observation_time_rfc822","weather","temperature_string",
	"temp_f","temp_c","relative_humidity","wind_string","wind_dir","wind_degrees","wind_mph",
	"wind_kt","pressure_string","pressure_mb","pressure_in","dewpoint_string","dewpoint_f",
	"dewpoint_c","visibility_mi","icon_url_base","two_day_history_url","icon_url_name","ob_url",
	"disclaimer_url","copyright_url","privacy_policy_url"]
 end
end
