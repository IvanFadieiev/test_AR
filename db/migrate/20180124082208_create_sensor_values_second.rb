class CreateSensorValuesSecond < ActiveRecord::Migration[5.1]
  def change
    create_table :sensor_values_second do |t|
      t.string    :device_id, null: false, default: ''
      t.string    :sensor_id, null: false, default: ''
      t.string    :value,     null: false, default: ''
      t.timestamp :timestamp, null: false
    end
  end
end
