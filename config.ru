require 'sequel'
require 'figaro'
require 'byebug'
require 'logger'

env = ENV['APP_ENV'] || 'development'

%w[models lib/support lib/rack_apps lib/middleware].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

CreatePid.for(file: __FILE__, pid: Process.pid)

Figaro.application = Figaro::Application.new(environment: env, path: './config/application.yml')
Figaro.load

$logger = Logger.new("./logs/#{env}.log")

App = Rack::Builder.new do
  use Rack::CommonLogger, $logger
  use Rack::ContentType, 'application/json'

  map '/' do
    run DataEndpoint.new
  end
end

run App
