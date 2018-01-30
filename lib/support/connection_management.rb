require 'yaml'
require 'pg'

# ConnectionManagement
class ConnectionManagement
  class << self
    DB_FILE_PATH = './config/database.yml'

    def connect_to_db
      PG.connect(db_config)
    end

    def db
      YAML.safe_load(db_config_file)[ENV['PASSENGER_APP_ENV']]
    end

    private

    def db_config_file
      File.open(DB_FILE_PATH)
    end

    def db_config
      db_data_hash(db)
    end

    def db_data_hash(parsed_db_data)
      raise "Check #{DB_FILE_PATH}" unless parsed_db_data
      {
        host:            parsed_db_data['host'],
        user:            parsed_db_data['username'],
        password:        parsed_db_data['password'],
        dbname:          parsed_db_data['database']
      }
    end
  end
end
