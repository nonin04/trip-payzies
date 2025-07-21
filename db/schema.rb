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

ActiveRecord::Schema[7.2].define(version: 2025_07_20_095846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advance_payments", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount", default: 0, null: false
    t.index ["expense_id", "participant_id"], name: "index_advance_payments_on_expense_id_and_participant_id", unique: true
    t.index ["expense_id"], name: "index_advance_payments_on_expense_id"
    t.index ["participant_id"], name: "index_advance_payments_on_participant_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code", null: false
    t.string "ja_name", null: false
    t.string "en_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.integer "decimal_position", default: 0, null: false
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.decimal "rate", precision: 15, scale: 8, null: false
    t.date "rate_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_exchange_rates_on_currency_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "payer_id", null: false
    t.integer "amount", null: false
    t.string "title", null: false
    t.date "payment_date", default: -> { "CURRENT_DATE" }, null: false
    t.string "place"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id"
    t.decimal "amount_local", precision: 15, scale: 2
    t.index ["currency_id"], name: "index_expenses_on_currency_id"
    t.index ["payer_id"], name: "index_expenses_on_payer_id"
    t.index ["trip_id"], name: "index_expenses_on_trip_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "name"], name: "index_members_on_group_id_and_name", unique: true
    t.index ["group_id"], name: "index_members_on_group_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id", "name"], name: "index_participants_on_trip_id_and_name", unique: true
    t.index ["trip_id"], name: "index_participants_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.integer "settlement_status", default: 0, null: false
    t.date "departure_date", default: -> { "CURRENT_DATE" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.string "share_token"
    t.bigint "currency_id"
    t.index ["currency_id"], name: "index_trips_on_currency_id"
    t.index ["group_id"], name: "index_trips_on_group_id"
    t.index ["share_token"], name: "index_trips_on_share_token"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "advance_payments", "expenses", on_delete: :cascade
  add_foreign_key "advance_payments", "participants", on_delete: :restrict
  add_foreign_key "exchange_rates", "currencies"
  add_foreign_key "expenses", "currencies"
  add_foreign_key "expenses", "participants", column: "payer_id", on_delete: :restrict
  add_foreign_key "expenses", "trips", on_delete: :cascade
  add_foreign_key "groups", "users", on_delete: :cascade
  add_foreign_key "members", "groups", on_delete: :cascade
  add_foreign_key "participants", "trips", on_delete: :cascade
  add_foreign_key "trips", "currencies"
  add_foreign_key "trips", "groups", on_delete: :nullify
  add_foreign_key "trips", "users", on_delete: :cascade
end
