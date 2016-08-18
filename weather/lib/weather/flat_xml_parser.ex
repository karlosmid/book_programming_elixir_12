defmodule Weather.FlatXmlParser do
  @moduledoc """
    Using simple regex, extracts from xml elements value.
  """
  def convert_xml_to_list(xml_string) do
   discover_elements(xml_string) |>
   Enum.map(fn(x) -> make_element_value_tuple(x,xml_string) end)
 end
 def make_element_value_tuple(element,xml) do
   regex_string = "<#{element}.*>(?<value>.*)<\/#{element}>"
   value = Regex.named_captures(~r/#{regex_string}/,xml)["value"]
   {element,value}
 end
 def discover_elements(xml) do
   Regex.scan(~r/<[^>\/]*>/, xml)
   |> Enum.map(fn(x) -> Enum.at(x,0) end)
   |> Enum.map(fn(x) -> String.replace(x,"<","") end)
   |> Enum.map(fn(x) -> String.replace(x,">","") end)
 end
end
