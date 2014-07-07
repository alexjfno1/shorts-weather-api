require 'spec_helper'
require_relative '../../lib/google_maps'

describe GoogleMaps do

  before do
    @stub_google_maps = WebMock::API.stub_request(:get, /maps/)
  end

  it "should call the Google Maps API on initialize" do
    GoogleMaps.new("50.7", "00.5")
    expect(a_request(:get, /maps/)).to have_been_made
  end

  it "should call the Google Maps API with latitude and longitude" do
    GoogleMaps.new("50.7", "00.5")
    expect(a_request(:get, /maps.*(latlng=50.7,00.5).*/)).to have_been_made
  end

  it "should return the formmated address" do
    @stub_google_maps.to_return(body: <<-JSON)
    {"results":[{"formatted_address":"1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK"}]}
    JSON
    expect(GoogleMaps.new("51.0", "00.5").formatted_address).to eq("1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK")
  end

#  it "should throw a exception if it cannot get the formatted address" do
#    @stub_google_maps.to_return(body: <<-JSON)
#    {"error":"Whoops, something when wrong here!"}
#    JSON
#  end

end
