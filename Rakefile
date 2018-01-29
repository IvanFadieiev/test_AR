require 'active_record_migrations'
require 'yaml'

Dir.glob('lib/tasks/*.rake').each { |r| load r }

ActiveRecordMigrations.configure do |c|
  c.yaml_config = 'config/database.yml'
  # c.environment = ENV['db']             # now using RAILS_ENV
end

ActiveRecordMigrations.load_tasks
