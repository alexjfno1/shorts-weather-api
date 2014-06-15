module Helpers

  def stub_google_api_to_return_address address
    WebMock::API.stub_request(:get, /maps/).to_return(body: <<-JSON)
      { "results": [{ "formatted_address":"#{address}" }] }
    JSON
  end

end
