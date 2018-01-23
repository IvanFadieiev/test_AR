require 'yaml'

# DbSwitcher
class DbSwitcher
  class << self
    FILE_PATH = './config/current_db.yml'.freeze
    KEY = 'current_db'.freeze
    CASES = {
      first: 'first',
      second: 'second'
    }.freeze

    def write_file!
      toggle = yaml_file.tap do |f|
        f[KEY] = db_switch
      end

      File.open(FILE_PATH, 'w') do |f|
        f.write toggle.to_yaml
      end
    end

    def yaml_file
      YAML.load(file)
    end

    private

    def file
      File.open(FILE_PATH)
    end

    def db_switch
      yaml_file[KEY].eql?(CASES[:first]) ? CASES[:second] : CASES[:first]
    end
  end
end
