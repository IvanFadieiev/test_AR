# namespace :db do
#   db_config       = YAML.load(File.open('./config/database.yml'))
#   db_config_admin = db_config.merge('database' => 'postgres', 'schema_search_path' => 'public')
#
#   desc 'Create the database'
#   task :create do
#     ActiveRecord::Base.establish_connection(db_config_admin)
#     ActiveRecord::Base.connection.create_database(db_config['database'])
#     puts 'Database created.'
#   end
#
#   desc 'Migrate the database'
#   task :migrate do
#     ActiveRecord::Base.establish_connection(db_config)
#     ActiveRecord::Migrator.migrate('db/migrate/')
#     Rake::Task['db:schema'].invoke
#     puts 'Database migrated.'
#   end
#
#   desc 'Drop the database'
#   task :drop do
#     ActiveRecord::Base.establish_connection(db_config_admin)
#     ActiveRecord::Base.connection.drop_database(db_config['database'])
#     puts 'Database deleted.'
#   end
#
#   desc 'Reset the database'
#   task :reset => [:drop, :create, :migrate]
#
#   desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
#   task :schema do
#     ActiveRecord::Base.establish_connection(db_config)
#     require 'active_record/schema_dumper'
#     filename = 'db/schema.rb'
#     File.open(filename, 'w:utf-8') do |file|
#       ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
#     end
#   end
# end

namespace :db do
  require './lib/middleware/connection_management'
  require 'sequel'
  namespace :migrate do
    Sequel.extension :migration

    task :connect do
      if ENV['DATABASE_URL']
        DB = ConnectionManagement.connect_to_db
      else
        puts 'ABORTING: You must set the DATABASE_URL environment variable!'
        exit false
      end
    end

    desc 'Perform migration reset (full erase and migration up).'
    task :reset => [:connect] do
      Sequel::Migrator.run(DB, 'migrations', :target => 0)
      Sequel::Migrator.run(DB, 'migrations')
      puts '*** db:migrate:reset executed ***'
    end

    desc 'Perform migration up/down to VERSION.'
    task :to => [:connect] do
      version = ENV['VERSION'].to_i
      if version == 0
        puts 'VERSION must be larger than 0. Use rake db:migrate:down to erase all data.'
        exit false
      end

      Sequel::Migrator.run(DB, 'migrations', :target => version)
      puts "*** db:migrate:to VERSION=[#{version}] executed ***"
    end

    desc 'Perform migration up to latest migration available.'
    task :up => [:connect] do
      Sequel::Migrator.run(DB, 'migrations')
      puts '*** db:migrate:up executed ***'
    end

    desc 'Perform migration down (erase all data).'
    task :down => [:connect] do
      Sequel::Migrator.run(DB, 'migrations', :target => 0)
      puts '*** db:migrate:down executed ***'
    end
  end
end
