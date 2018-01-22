class Setting < ActiveRecord::Migration[5.0]
  def change
    create_table :sensor_values do |t|
      t.string    :sensor_id, null: false, default: ''
      t.string    :value,     null: false, default: ''
      t.datetime  :timestamp, null: false

      t.timestamps null: false
    end
  end
end
