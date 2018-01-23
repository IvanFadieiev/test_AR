# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:sensor_values_second) do
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
