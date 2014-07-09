require 'spec_helper'

feature "Derive latitude and longitude values from an address using the Google Maps API" do

  before do
    stub_google_maps_position_finder("51.31", "-01.25")
  end

  scenario "returns a 200" do
    get "/shorts-weather/get-position?address=1%20Linden%20Road%20Coxheath"
    expect(last_response).to be_ok
  end

  context "returns a 400 bad request if" do

    scenario "address parameter is not provided" do
      get "/shorts-weather/get-position"
      expect(last_response).to be_bad_request
    end

  end

  scenario "returns latitude coordinate" do
    get "/shorts-weather/get-position?address=1%20Linden%20Road%20Coxheath"
    expect(last_response.body).to include('"latitude":51.31')
  end

  scenario "returns longitude coordinate" do
    get "/shorts-weather/get-position?address=1%20Linden%20Road%20Coxheath"
    expect(last_response.body).to include('"longitude":-1.25')
  end

end
