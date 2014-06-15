require 'sinatra'
require 'faraday'
require 'json'

get "/shorts-weather" do
  halt 400 unless params[:lat] && params[:long]
  google_maps_api = Faraday.new(url: "http://maps.googleapis.com/maps/api/geocode")
  google_response = google_maps_api.get("json?latlng=#{params[:lat]},#{params[:long]}&sensor=false")
  formatted_address = JSON.parse(google_response.body)["results"][0]["formatted_address"]
  { address: formatted_address }.to_json
end
