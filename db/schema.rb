# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180117150202) do

  create_table "accounts", force: :cascade do |t|
    t.integer "number",    limit: 4
    t.integer "balance",   limit: 4
    t.integer "user_id",   limit: 4
    t.integer "locker_id", limit: 4
  end

  add_index "accounts", ["locker_id"], name: "index_accounts_on_locker_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.string  "category",    limit: 255
    t.integer "amount",      limit: 4
    t.integer "no_of_years", limit: 4
    t.integer "account_id",  limit: 4
  end

  add_index "loans", ["account_id"], name: "index_loans_on_account_id", using: :btree

  create_table "lockers", force: :cascade do |t|
    t.string  "section", limit: 255
    t.integer "number",  limit: 4
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "number",     limit: 4
    t.boolean "category"
    t.integer "amount",     limit: 4
    t.integer "account_id", limit: 4
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.string  "phone_no",  limit: 255
    t.string  "email",     limit: 255
    t.integer "aadhar_no", limit: 8
  end

  add_foreign_key "accounts", "lockers"
  add_foreign_key "accounts", "users"
  add_foreign_key "loans", "accounts"
  add_foreign_key "transactions", "accounts"
end
