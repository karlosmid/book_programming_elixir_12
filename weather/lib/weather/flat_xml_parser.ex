defmodule Weather.FlatXmlParser do
  @moduledoc """
    Using simple regex, extracts from xml elements value.
  """
  def convert_xml_to_list(xml_string,elements) do
   elements |>
   Enum.map(fn(x) -> make_element_value_tuple(x,xml_string) end)
 end
 def make_element_value_tuple(element,xml) do
   regex_string = "<#{element}.*>(?<value>.*)<\/#{element}>"
   value = Regex.named_captures(~r/#{regex_string}/,xml)["value"]
   {element,value}
 end
end
