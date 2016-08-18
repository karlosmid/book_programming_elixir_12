defmodule Weather.WeatherData do
  @moduledoc """
    Fetches weather data in xml format from weather gov site
    based on city code
  """
  @weather_url_base Application.get_env(:weather, :weather_url)
  def fetch(city_code) do
    weather_url(city_code)
    |> HTTPoison.get
    |> handle_response
  end
  def weather_url(city_code) do
    "#{@weather_url_base}#{city_code}.xml"
  end
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end
  def handle_response({_, %{status_code: _, body: body}}) do
    { :error, body }
  end
end
