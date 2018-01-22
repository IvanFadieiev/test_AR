require 'active_record'
require 'figaro'
require 'rack'
require 'byebug'

env = ENV['APP_ENV'] || 'development'

%w[models lib/support].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

Process.daemon(true, true) if ENV['APP_ENV'].eql?('production')

CreatePid.for(file: __FILE__, pid: Process.pid)

Figaro.application = Figaro::Application.new(environment: env, path: './config/application.yml')
Figaro.load

file = File.open('./config/database.yml')
DB   = YAML.load(file)

ActiveRecord::Base.logger = Logger.new(STDOUT) unless ENV['APP_ENV'].eql?('production')
logger = Logger.new("./logs/#{env}.log")

ActiveRecord::Base.establish_connection(adapter:  DB['adapter'],
                                        host: DB['host'],
                                        username: DB['username'],
                                        password: DB['password'],
                                        database: DB['database'])

# App
class App
  def call(args)
    [200, {}, [SensorValue.all.inspect]]
  end
end

use Rack::CommonLogger, logger
run App.new
