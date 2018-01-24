require './lib/middleware/connection_management'

ENV['APP_ENV'] ||= 'development'

conn = ConnectionManagement.connect_to_db

sql = 'BEGIN;' \
      'ALTER TABLE sensor_values RENAME TO sensor_values_dup;' \
      'ALTER TABLE sensor_values_second RENAME TO sensor_values;' \
      'ALTER TABLE sensor_values_dup RENAME TO sensor_values_second;' \
      'COMMIT;'

conn.exec(sql)

conn.close if conn
