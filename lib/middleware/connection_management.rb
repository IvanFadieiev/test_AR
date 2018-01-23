require 'yaml'

# ConnectionManagement
class ConnectionManagement
  def initialize(app)
    @app = app
  end

  def call(env)
    connect_to_db
    @app.call(env)
  end

  def connect_to_db
    ActiveRecord::Base.establish_connection(db_config)
  end

  private

  def db_config_file
    File.open('./config/database.yml')
  end

  def db
    YAML.load(db_config_file)
  end

  def db_config
    {
      adapter:  db['adapter'],
      host:     db['host'],
      username: db['username'],
      password: db['password'],
      database: db['database']
    }
  end
end
