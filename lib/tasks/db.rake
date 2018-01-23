require 'sequel'
require './lib/middleware/connection_management'

namespace :db do
  desc 'Create the database'
  task :create do
    config = ConnectionManagement.db
    Sequel.connect(config.merge('database' => 'postgres')) do |db|
      db.execute "DROP DATABASE IF EXISTS #{config['database']}"
      db.execute "CREATE DATABASE #{config['database']}"
    end
    puts 'Database created.'
  end
end
