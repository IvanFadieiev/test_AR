require 'active_record'
require 'figaro'
require 'rack'
require 'byebug'

env = ENV['APP_ENV'] || 'development'

%w[models lib/support lib/rack_apps lib/middleware].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

CreatePid.for(file: __FILE__, pid: Process.pid)

Figaro.application = Figaro::Application.new(environment: env, path: './config/application.yml')
Figaro.load

ActiveRecord::Base.logger = Logger.new(STDOUT) unless ENV['APP_ENV'].eql?('production')
logger = Logger.new("./logs/#{env}.log")

App = Rack::Builder.new do
  map '/data' do
    DbSwitcher.write_file! # switch DB connections
    use ConnectionManagement
    use Rack::CommonLogger, logger
    run DataEndpoint.new
  end
end

run App