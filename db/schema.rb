# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_14_145700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.integer "paid"
    t.integer "cost"
    t.string "status"
    t.string "payment_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_orders_on_organization_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_products", force: :cascade do |t|
    t.bigint "orders_id", null: false
    t.bigint "products_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["orders_id"], name: "index_orders_products_on_orders_id"
    t.index ["products_id"], name: "index_orders_products_on_products_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "verification_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.text "description"
    t.integer "inventory"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_products_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.bigint "organization_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "orders", "organizations"
  add_foreign_key "orders", "users"
  add_foreign_key "orders_products", "orders", column: "orders_id"
  add_foreign_key "orders_products", "products", column: "products_id"
  add_foreign_key "products", "organizations"
  add_foreign_key "users", "organizations"
end
