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

ActiveRecord::Schema[7.2].define(version: 2025_06_18_095516) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authorizations", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_authorizations_on_uid_and_provider", unique: true
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "calculators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "uk_name", default: "", null: false
    t.string "en_name", default: "", null: false
    t.text "uk_notes"
    t.text "en_notes"
    t.string "color", default: "#8fba3b"
    t.index ["slug"], name: "index_calculators_on_slug", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "uk_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 0, null: false
    t.string "en_name"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "field_id"
    t.boolean "preferable", default: false, null: false
    t.index ["field_id"], name: "index_categories_on_field_id"
  end

  create_table "category_categoryables", force: :cascade do |t|
    t.bigint "category_id"
    t.string "categoryable_type"
    t.bigint "categoryable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_categoryables_on_category_id"
    t.index ["categoryable_type", "categoryable_id", "category_id"], name: "unique_of_category_categoryables_index", unique: true
    t.index ["categoryable_type", "categoryable_id"], name: "index_category_categoryables_on_categoryable"
  end

  create_table "diapers_periods", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "period_start", null: false
    t.integer "period_end", null: false
    t.integer "usage_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_diapers_periods_on_category_id"
  end

  create_table "feature_flags", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feature_flags_on_name", unique: true
  end

  create_table "fields", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit", default: 0
    t.string "uk_label", default: "", null: false
    t.string "en_label", default: "", null: false
    t.string "var_name", default: "", null: false
    t.bigint "calculator_id", null: false
    t.decimal "value", precision: 10, scale: 2
    t.index ["calculator_id"], name: "index_fields_on_calculator_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "en_description"
    t.text "uk_description"
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "formulas", force: :cascade do |t|
    t.string "expression", default: "", null: false
    t.string "uk_label", default: "", null: false
    t.string "en_label", default: "", null: false
    t.string "uk_unit"
    t.string "en_unit"
    t.bigint "calculator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 0, null: false
    t.string "relation"
    t.index ["calculator_id"], name: "index_formulas_on_calculator_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title", null: false
    t.string "message", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.integer "period_start"
    t.integer "period_end"
    t.integer "usage_amount"
    t.bigint "category_id", null: false
    t.decimal "price", precision: 10, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_periods_on_category_id"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "sum", precision: 8, scale: 2
    t.string "priceable_type"
    t.bigint "priceable_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "priceable_id", "priceable_type"], name: "idx_on_category_id_priceable_id_priceable_type_1fa9ce7f24", unique: true
    t.index ["category_id"], name: "index_prices_on_category_id"
    t.index ["priceable_type", "priceable_id"], name: "index_prices_on_priceable"
  end

  create_table "product_types", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_product_types_on_uuid", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title"
    t.bigint "product_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
    t.index ["title"], name: "index_products_on_title", unique: true
    t.index ["uuid"], name: "index_products_on_uuid", unique: true
  end

  create_table "select_options", force: :cascade do |t|
    t.bigint "field_id", null: false
    t.string "key"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_select_options_on_field_id"
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "title", default: "ZeroWaste", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "country"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.boolean "blocked", default: false, null: false
    t.integer "role", default: 0
    t.boolean "receive_recomendations", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "authorizations", "users"
  add_foreign_key "categories", "fields"
  add_foreign_key "category_categoryables", "categories"
  add_foreign_key "diapers_periods", "categories"
  add_foreign_key "fields", "calculators"
  add_foreign_key "formulas", "calculators"
  add_foreign_key "periods", "categories"
  add_foreign_key "select_options", "fields"
end
