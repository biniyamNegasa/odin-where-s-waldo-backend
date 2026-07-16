# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_07_16_090001) do
  create_table "image_coordinates", force: :cascade do |t|
    t.string "name"
    t.json "waldo", default: []
    t.json "wenda", default: []
    t.json "wizard", default: []
    t.json "odlaw", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_image_coordinates_on_name", unique: true
  end

  create_table "timers", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "found_characters", default: [], null: false
    t.index ["image_name"], name: "index_timers_on_image_name"
  end
end
