require 'sequel'
require './lib/middleware/connection_management'

db = ConnectionManagement.connect_to_db

sql = 'BEGIN;' \
      'ALTER TABLE sensor_values RENAME TO sensor_values_dup;' \
      'ALTER TABLE sensor_values_second RENAME TO sensor_values;' \
      'ALTER TABLE sensor_values_dup RENAME TO sensor_values_second;' \
      'COMMIT;'

db.run(sql)
db.disconnect
