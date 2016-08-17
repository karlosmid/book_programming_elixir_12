defmodule FlatXmlParserTest do
  use ExUnit.Case
  doctest Weather
  import Weather.WeatherData, only: [fetch: 1 ]
  import Weather.FlatXmlParser, only: [make_element_value_tuple: 2, convert_xml_to_list: 2 ]

  test "get flat xml element" do
    assert make_element_value_tuple("credit",kdto_xml_string) == {"credit","NOAA's National Weather Service"}
  end

  test "make a list of xml element,value maps" do
    assert convert_xml_to_list(kdto_xml_string,elements) == [{"credit","NOAA's National Weather Service"},
                                                            {"credit_URL","http://weather.gov/"}]
  end

  def kdto_xml_string do
    elem(Weather.WeatherData.fetch("KDTO"),1)
  end
  def elements do
    ["credit","credit_URL"]
  end
end
