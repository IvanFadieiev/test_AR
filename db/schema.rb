# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180123140745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sensor_values", id: :serial, force: :cascade do |t|
    t.string "device_id", default: "", null: false
    t.string "sensor_id", default: "", null: false
    t.string "value", default: "", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sensor_values_on_device_id"
    t.index ["sensor_id"], name: "index_sensor_values_on_sensor_id"
    t.index ["timestamp"], name: "index_sensor_values_on_timestamp"
  end

  create_table "sensor_values_second", id: :serial, force: :cascade do |t|
    t.string "device_id", default: "", null: false
    t.string "sensor_id", default: "", null: false
    t.string "value", default: "", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sensor_values_second_on_device_id"
    t.index ["sensor_id"], name: "index_sensor_values_second_on_sensor_id"
    t.index ["timestamp"], name: "index_sensor_values_second_on_timestamp"
  end

end
