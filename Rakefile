if ENV["RACK_ENV"] != "production"
  require 'rspec/core/rake_task'
  task default: :spec
  RSpec::Core::RakeTask.new(:spec)
end
