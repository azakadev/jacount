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

ActiveRecord::Schema.define(version: 2020_10_12_225411) do

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
    t.string "subtotal"
    t.string "discount"
    t.string "currency"
    t.string "exchange_rate"
    t.string "total"
    t.string "type_of_vaucher"
    t.string "payment_method"
    t.string "expedition_place"
    t.string "confirmation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
