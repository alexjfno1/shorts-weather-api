require 'spec_helper'
require_relative '../../lib/google_maps_position_finder'

describe GoogleMapsPositionFinder do

  before do
    @stub_position_finder = WebMock::API.stub_request(:get, /geocode/)
  end

  it "should call the Google Maps Position Finder API on initialize" do
    GoogleMapsPositionFinder.new("1 Linden Road, Coxheath")
    expect(a_request(:get, /geocode/)).to have_been_made
  end

  it "should call the Google Maps Position Finder API with an address" do
    GoogleMapsPositionFinder.new("1 Linden Road Coxheath")
    expect(a_request(:get, /geocode.*(address=1%20Linden%20Road%20Coxheath).*/)).to have_been_made
  end

  it "should return the latitude for the given address" do
    @stub_position_finder.to_return(body: <<-JSON)
    {"results":[{"geometry":{"location":{"lat":51.21,"lng":-1.40}}}]}
    JSON
    expect(GoogleMapsPositionFinder.new("1 Linden Road Coxheath").latitude).to eq(51.21)
  end

  it "should return the longitude for the given address" do
    @stub_position_finder.to_return(body: <<-JSON)
    {"results":[{"geometry":{"location":{"lat":51.00,"lng":-1.43}}}]}
    JSON
    expect(GoogleMapsPositionFinder.new("1 Linden Road Coxheath").longitude).to eq(-1.43)
  end

end
