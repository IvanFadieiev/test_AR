# TODO: move this file into the new project which will do
# TODO: raw data aggregation operations

require './lib/support/connection_management'

ENV['PASSENGER_APP_ENV'] ||= 'development'

conn = ConnectionManagement.connect_to_db

sql = 'BEGIN;' \
      'ALTER TABLE sensor_values RENAME TO sensor_values_dup;' \
      'ALTER TABLE sensor_values_second RENAME TO sensor_values;' \
      'ALTER TABLE sensor_values_dup RENAME TO sensor_values_second;' \
      'COMMIT;'

conn.exec(sql)

conn.close if conn
