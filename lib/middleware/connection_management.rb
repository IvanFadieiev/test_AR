require 'yaml'

# ConnectionManagement
class ConnectionManagement
  def initialize(app)
    @app = app
  end

  def call(env)
    ActiveRecord::Base.establish_connection(db_config)
    @app.call env
  end

  private

  def db_config_file
    File.open('./config/database.yml')
  end

  def db
    YAML.load(db_config_file)
  end

  def current_db_file
    File.open('./config/current_db.yml')
  end

  def current_db_name
    YAML.load(current_db_file)['current_db']
  end

  def db_config
    current_db = current_db_name
    {
      adapter:  db[current_db]['adapter'],
      host:     db[current_db]['host'],
      username: db[current_db]['username'],
      password: db[current_db]['password'],
      database: db[current_db]['database']
    }
  end
end
