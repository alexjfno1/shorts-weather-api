require 'sinatra'
require 'sinatra/assetpack'
require_relative 'lib/google_maps'
require_relative 'lib/google_maps_position_finder'
require_relative 'lib/weather_forecast'

register Sinatra::AssetPack

assets {
    css :app, ['/css/*.css']
    js :app, ['/js/*.js']
    css_compression :simple
}

get "/" do
  erb :shorts_weather
end

get "/shorts-weather" do
  content_type :json
  halt 400 unless params[:lat] && params[:long]
  maps = GoogleMaps.new(params[:lat], params[:long])
  weather = WeatherForecast.new(params[:lat], params[:long])
  {
    address: maps.formatted_address,
    is_it_shorts_weather: weather.shorts_weather?,
  }.to_json
end

get "/shorts-weather/get-position" do
  content_type :json
  halt 400 unless params[:address]
  position_finder = GoogleMapsPositionFinder.new(params[:address])
  {
    latitude: position_finder.latitude,
    longitude: position_finder.longitude,
    address: position_finder.address
  }.to_json
end
