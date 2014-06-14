require 'spec_helper'

feature "Is it shorts weather tomorrow prediction service" do

  scenario "returns a 200" do
    get "/shorts-weather"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("OK!")
  end

end
