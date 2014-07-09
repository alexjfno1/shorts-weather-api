module Helpers

  def stub_google_api_to_return_address(address)
    WebMock::API.stub_request(:get, /maps/).to_return(body: <<-json)
      { "results": [{ "formatted_address":"#{address}" }] }
    json
  end

  def stub_google_maps_position_finder(lat, lng)
    WebMock::API.stub_request(:get, /geocode/).to_return(body: <<-json)
      {"results":[{"formatted_address":"1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK", "geometry":{"location":{"lat":#{lat.to_f},"lng":#{lng.to_f}}}}]}
    json
  end

end
