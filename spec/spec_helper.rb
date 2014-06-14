require 'rack/test'
require 'capybara/rspec'
require_relative '../app.rb'

RSpec.configure do |config|

  def app
    Sinatra::Application
  end

  config.order = :random
  config.include Rack::Test::Methods
end

