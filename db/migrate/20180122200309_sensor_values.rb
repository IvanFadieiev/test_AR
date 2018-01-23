class SensorValues < ActiveRecord::Migration[5.0]
  def change
    create_table :sensor_values do |t|
      t.string    :device_id, null: false, default: ''
      t.string    :sensor_id, null: false, default: ''
      t.string    :value,     null: false, default: ''
      t.datetime  :timestamp, null: false

      t.timestamps null: false
    end
    add_index :sensor_values, :timestamp
    add_index :sensor_values, :sensor_id
    add_index :sensor_values, :device_id
  end
end
