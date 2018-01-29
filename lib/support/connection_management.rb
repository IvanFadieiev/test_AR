require 'yaml'
require 'pg'

# ConnectionManagement
class ConnectionManagement
  class << self
    def connect_to_db
      PG.connect(db_config)
    end

    def db
      YAML.load(db_config_file)[ENV['PASSENGER_APP_ENV']]
    end

    private

    def db_config_file
      File.open('./config/database.yml')
    end

    def db_config
      {
        host:            db['host'],
        user:            db['username'],
        password:        db['password'],
        dbname:          db['database']
      }
    end
  end
end
