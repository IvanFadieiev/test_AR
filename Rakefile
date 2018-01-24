require 'yaml'

Dir.glob('lib/tasks/*.rake').each { |r| load r }

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks
