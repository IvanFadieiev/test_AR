require 'figaro'
require 'byebug'
require 'pp'

ENV['APP_ENV'] ||= 'development'
env = ENV['APP_ENV']

%w[lib/support lib/rack_apps lib/middleware].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

Figaro.application = Figaro::Application.new(environment: env, path: './config/application.yml')
Figaro.load

$logger = Logger.new("./logs/#{env}.log")
