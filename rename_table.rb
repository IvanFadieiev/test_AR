require 'active_record'
require './lib/middleware/connection_management'

ConnectionManagement.new('console').connect_to_db

sql = 'BEGIN;' \
      'ALTER TABLE sensor_values RENAME TO sensor_values_dup;' \
      'ALTER TABLE sensor_values_second RENAME TO sensor_values;' \
      'ALTER TABLE sensor_values_dup RENAME TO sensor_values_second;' \
      'COMMIT;'

ActiveRecord::Base.connection.execute(sql)
