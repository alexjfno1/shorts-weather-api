require 'json'

class GoogleMaps

  attr_reader :formatted_address

  def initialize(lat, long)
    @response = call_api(lat, long)
  end

  def call_api lat, long
    google_maps_api = Faraday.new(url: "http://maps.googleapis.com/maps/api/geocode")
    google_maps_api.get("json?latlng=#{lat},#{long}&sensor=false")
  end

  def formatted_address
    JSON.parse(@response.body)["results"][0]["formatted_address"]
  end

end
