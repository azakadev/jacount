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

ActiveRecord::Schema.define(version: 2020_10_20_122137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "voucher_node"
    t.string "version"
    t.string "serie"
    t.string "folio"
    t.string "date"
    t.string "stamp"
    t.string "way_to_pay"
    t.string "certificate_number"
    t.string "certificate"
    t.string "payment_conditions"
    t.decimal "subtotal", precision: 10, scale: 2
    t.string "discount"
    t.string "currency"
    t.string "exchange_rate"
    t.decimal "total", precision: 10, scale: 2
    t.string "type_of_vaucher"
    t.string "payment_method"
    t.string "expedition_place"
    t.string "confirmation"
    t.string "transmiter_rfc"
    t.string "transmiter_name"
    t.string "transmiter_fiscal_regime"
    t.string "receiver_rfc"
    t.string "receiver_name"
    t.string "receiver_cfdi_use"
    t.string "initial_payment_date"
    t.string "final_payment_date"
    t.string "payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payroll_perceptions", force: :cascade do |t|
    t.string "perception_type"
    t.string "code"
    t.string "concept"
    t.string "taxed_amount"
    t.string "exempt_amount"
    t.bigint "bill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_payroll_perceptions_on_bill_id"
  end

  add_foreign_key "payroll_perceptions", "bills"
end
