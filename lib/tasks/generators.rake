namespace :g do
  desc 'Generate migration'
  task :migration do
    name = ARGV[1] || raise('Specify name: rake g:migration your_migration')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = File.expand_path("../../../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split('_').map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration[5.0]
  def change
  end
end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end

  desc 'Generate token'
  task :token do
    require 'securerandom'

    puts SecureRandom.hex(64)
  end
end
