class SensorValuesSecond < ActiveRecord::Migration[5.0]
  def change
    create_table :sensor_values_second do |t|
      t.string    :device_id, null: false, default: ''
      t.string    :sensor_id, null: false, default: ''
      t.string    :value,     null: false, default: ''
      t.datetime  :timestamp, null: false

      t.timestamps null: false
    end
    add_index :sensor_values_second, :timestamp
    add_index :sensor_values_second, :sensor_id
    add_index :sensor_values_second, :device_id
  end
end
