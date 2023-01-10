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

ActiveRecord::Schema[7.0].define(version: 2023_01_10_030120) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "personal_records", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "user_id"
    t.bigint "run_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_personal_records_on_run_id"
    t.index ["user_id"], name: "index_personal_records_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.date "date"
    t.float "distance"
    t.integer "time"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "uuid"
    t.date "signed_in_at"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "personal_records", "runs"
  add_foreign_key "personal_records", "users"
  add_foreign_key "runs", "users"
end
