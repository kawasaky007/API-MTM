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

ActiveRecord::Schema.define(version: 2021_08_18_083947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "full_name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "auth_code"
    t.boolean "active"
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "banners", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_banners_on_slug", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photo"
    t.string "url"
    t.boolean "showable"
    t.string "color"
    t.string "slug"
    t.boolean "independent_brand"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "category_linkers", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_linkers_on_category_id"
    t.index ["product_id"], name: "index_category_linkers_on_product_id"
  end

  create_table "facebook_auths", force: :cascade do |t|
    t.text "access_token"
    t.integer "fb_user_id"
    t.integer "expires_in"
    t.text "signed_request"
    t.integer "data_access_expiration_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flash_sale_details", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "limit_per_user"
    t.integer "total"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "discount"
    t.integer "flash_sale_id"
    t.index ["product_id"], name: "index_flash_sale_details_on_product_id"
  end

  create_table "flash_sales", force: :cascade do |t|
    t.string "name"
    t.datetime "active_time"
    t.datetime "expired_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "popup"
    t.string "photo"
    t.index ["slug"], name: "index_flash_sales_on_slug", unique: true
  end

  create_table "ordered_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_ordered_products_on_order_id"
    t.index ["product_id"], name: "index_ordered_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.string "province"
    t.string "district"
    t.bigint "transport_id", null: false
    t.string "payment_method"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "address"
    t.string "status"
    t.string "details"
    t.index ["transport_id"], name: "index_orders_on_transport_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "photoable_type", null: false
    t.bigint "photoable_id", null: false
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["photoable_type", "photoable_id"], name: "index_photos_on_photoable"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "url"
    t.decimal "price", precision: 10, scale: 2
    t.float "discount"
    t.text "details"
    t.integer "amount"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "flash_sale_detail_id"
    t.string "slug"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "transports", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.decimal "price"
    t.string "transport_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number"
    t.string "full_name"
    t.string "sex"
    t.string "password_digest"
    t.string "email"
    t.string "address_city"
    t.string "address_district"
    t.string "address_ward"
    t.string "address_details"
    t.datetime "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "resgistation_activated"
    t.string "auth_code"
    t.boolean "active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "category_linkers", "categories"
  add_foreign_key "category_linkers", "products"
  add_foreign_key "flash_sale_details", "products"
  add_foreign_key "ordered_products", "orders"
  add_foreign_key "ordered_products", "products"
  add_foreign_key "orders", "transports"
  add_foreign_key "orders", "users"
end
