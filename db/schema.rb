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

ActiveRecord::Schema.define(version: 2021_04_09_171311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fields", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "calculator_id", null: false
    t.string "selector", null: false
    t.string "type", null: false
    t.string "label", null: false
    t.string "name"
    t.string "value"
    t.string "unit"
    t.integer "from"
    t.integer "to"
    t.integer "kind", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["calculator_id"], name: "index_fields_on_calculator_id"
    t.index ["uuid"], name: "index_fields_on_uuid", unique: true
  end

  create_table "product_types", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_product_types_on_uuid", unique: true
  end

end
