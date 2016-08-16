defmodule Weather.WeatherData do
  def fetch(city_code) do
    weather_url(city_code)
    |> HTTPoison.get
    |> handle_response
  end
  def weather_url(city_code) do
    "http://w1.weather.gov/xml/current_obs/#{city_code}.xml"
  end
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end
  def handle_response({_, %{status_code: _, body: body}}) do
    { :error, body }
  end
end
