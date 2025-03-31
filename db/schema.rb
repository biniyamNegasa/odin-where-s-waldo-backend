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

ActiveRecord::Schema[7.2].define(version: 2025_03_31_121309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "image_coordinates", force: :cascade do |t|
    t.string "name"
    t.integer "waldo", default: [], array: true
    t.integer "wenda", default: [], array: true
    t.integer "wizard", default: [], array: true
    t.integer "odlaw", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timers", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_name"], name: "index_timers_on_image_name"
  end
end
