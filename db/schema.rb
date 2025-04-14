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

ActiveRecord::Schema[7.2].define(version: 2025_04_14_151745) do
  create_table "actions", force: :cascade do |t|
    t.string "action_type"
    t.text "data"
    t.integer "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_actions_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "tx_hash"
    t.string "sender"
    t.string "receiver"
    t.boolean "success"
    t.string "tx_time"
    t.string "gas_burnt"
    t.integer "actions_count"
    t.integer "api_id"
    t.string "api_created_at"
    t.string "api_updated_at"
    t.integer "block_height"
    t.string "block_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tx_hash"], name: "index_transactions_on_tx_hash", unique: true
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "action_id", null: false
    t.string "deposit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_transfers_on_action_id"
  end

  add_foreign_key "actions", "transactions", on_delete: :cascade
  add_foreign_key "transfers", "actions", on_delete: :cascade
end
