require 'faraday'
require 'json'

class GoogleMaps

  attr_reader :formatted_address

  def initialize(lat, long)
    @response = call_api(lat, long)
  end

  def formatted_address
    JSON.parse(@response.body)["results"][0]["formatted_address"]
  end

  private

  def call_api lat, long
    google_maps_api = Faraday.new(url: "http://maps.googleapis.com/maps/api/geocode") do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    google_maps_api.get("json?latlng=#{lat},#{long}&sensor=false")
  end

end
