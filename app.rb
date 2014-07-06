require 'sinatra'
require 'faraday'
require_relative 'lib/google_maps'

get "/shorts-weather" do
  halt 400 unless params[:lat] && params[:long]
  maps = GoogleMaps.new(params[:lat], params[:long])
  { address: maps.formatted_address }.to_json
end
