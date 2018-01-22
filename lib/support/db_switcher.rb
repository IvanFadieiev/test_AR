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

    private

    def file
      File.open(FILE_PATH)
    end

    def yaml_file
      YAML.load(file)
    end

    def db_switch
      # CASES2 = ['first', 'second']
      #
      # current_index = CASES2.find_index(yaml_file[KEY])
      # next_index = current_index + 1
      # index = next_index > (CASES2.size - 1) ? 0 : next_index
      # CASES2[index]
      yaml_file[KEY].eql?(CASES[:first]) ? CASES[:second] : CASES[:first]
    end
  end
end
