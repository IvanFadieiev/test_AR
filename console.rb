require 'active_record'
require 'figaro'
require 'byebug'
require 'pp'
require 'jsonb_accessor'

env = ENV['APP_ENV'] || 'development'

%w[models lib/support lib/rack_apps lib/middleware].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

Figaro.application = Figaro::Application.new(environment: env, path: './config/application.yml')
Figaro.load

ConnectionManagement.new('console').connect_to_db
