require 'faraday'

class GoogleMapsPositionFinder

  attr_reader :latitude, :longitude

  def initialize(address)
    @response = call_api(address)
  end

  def latitude
    position["lat"]
  end

  def longitude
    position["lng"]
  end

  private

  def call_api(address)
    position_finder = Faraday.new(url: "http://maps.googleapis.com/maps/api/geocode") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    position_finder.get("json?address=#{URI::encode(address)}")
  end

  def position
    JSON.parse(@response.body)["results"][0]["geometry"]["location"]
  end

end
