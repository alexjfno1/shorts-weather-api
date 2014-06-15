require 'spec_helper'

feature "Is it shorts weather tomorrow prediction service" do

  before do
    stub_google_api_to_return_address("1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK")
  end

  scenario "returns a 200" do
    get "/shorts-weather?lat=51.0&long=0.01"
    expect(last_response).to be_ok
  end

  context "returns a 400 bad request if" do

    scenario "latitude parameter is not provided" do
      get "/shorts-weather?long=0.01"
      expect(last_response).to be_bad_request
    end

    scenario "longitude parameter is not provided" do
      get "/shorts-weather?lat=51.0"
      expect(last_response).to be_bad_request
    end

    scenario "no parameters are provided" do
      get "/shorts-weather"
      expect(last_response).to be_bad_request
    end

  end

  context "calls the Google Maps API and" do

    scenario "returns the address which is closest to the lat and long values passed" do
      stub_google_api_to_return_address("1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK")
      get "/shorts-weather?lat=51.0&long=0.01"
      expect(last_response.body).to include('"address":"1 Linden Road, Coxheath, Maidstone, Kent, ME17 4QS, UK"')
    end

  end

end
