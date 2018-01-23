# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:sensor_values) do
      primary_key :id
      String   :device_id, null: false, default: ''
      index    :device_id
      String   :sensor_id, null: false, default: ''
      index    :sensor_id
      String   :value,     null: false, default: ''
      DateTime :timestamp, null: false
      index    :timestamp

      DateTime :created_at, null: false
    end
  end
end


# def change
#   create_table :sensor_values do |t|
#     t.string    :device_id, null: false, default: ''
#     t.string    :sensor_id, null: false, default: ''
#     t.string    :value,     null: false, default: ''
#     t.datetime  :timestamp, null: false
#
#     t.timestamps null: false
#   end
#   add_index :sensor_values, :timestamp
#   add_index :sensor_values, :sensor_id
#   add_index :sensor_values, :device_id
# end