require 'rack/test'
require 'capybara/rspec'
require 'webmock/rspec'
require 'helpers'

require_relative '../app.rb'

RSpec.configure do |config|

  def app
    Sinatra::Application
  end

  config.order = :random
  config.include Rack::Test::Methods
  config.include Helpers

end

WebMock.allow_net_connect!

