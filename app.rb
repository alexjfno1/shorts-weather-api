require 'sinatra'
require_relative 'lib/google_maps'
require_relative 'lib/weather_forecast'

get "/shorts-weather" do
  halt 400 unless params[:lat] && params[:long]
  maps = GoogleMaps.new(params[:lat], params[:long])
  weather = WeatherForecast.new(params[:lat], params[:long])
  {
    address: maps.formatted_address,
    is_it_shorts_weather: weather.shorts_weather?,
  }.to_json
end
