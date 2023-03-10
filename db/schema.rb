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

ActiveRecord::Schema[7.0].define(version: 2023_03_04_010625) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invites", force: :cascade do |t|
    t.string "key"
    t.bigint "user_id"
    t.date "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "personal_records", force: :cascade do |t|
    t.string "category", null: false
    t.bigint "user_id"
    t.bigint "run_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_personal_records_on_run_id"
    t.index ["user_id"], name: "index_personal_records_on_user_id"
  end

  create_table "planned_runs", force: :cascade do |t|
    t.bigint "training_plan_id"
    t.bigint "user_id"
    t.date "date"
    t.float "distance"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_planned_runs_on_training_plan_id"
    t.index ["user_id"], name: "index_planned_runs_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.date "date"
    t.float "distance"
    t.integer "time"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "split"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "training_plan_memberships", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "training_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_training_plan_memberships_on_member_id"
    t.index ["training_plan_id"], name: "index_training_plan_memberships_on_training_plan_id"
  end

  create_table "training_plans", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "penalty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_training_plans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "uuid"
    t.date "signed_in_at"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invites", "users"
  add_foreign_key "personal_records", "users"
  add_foreign_key "planned_runs", "training_plans"
  add_foreign_key "planned_runs", "users"
  add_foreign_key "runs", "users"
  add_foreign_key "training_plan_memberships", "training_plans"
  add_foreign_key "training_plan_memberships", "users", column: "member_id"
  add_foreign_key "training_plans", "users"
end
