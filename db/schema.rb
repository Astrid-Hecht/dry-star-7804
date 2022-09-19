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

ActiveRecord::Schema.define(version: 2022_09_19_202642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amusement_parks", force: :cascade do |t|
    t.string "name"
    t.integer "admission_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "hospital_id"
    t.string "name"
    t.string "specialty"
    t.string "university"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
  end

  create_table "maintenances", force: :cascade do |t|
    t.bigint "ride_id"
    t.bigint "mechanic_id"
    t.index ["mechanic_id"], name: "index_maintenances_on_mechanic_id"
    t.index ["ride_id"], name: "index_maintenances_on_ride_id"
  end

  create_table "mechanics", force: :cascade do |t|
    t.string "name"
    t.integer "years_experience"
  end

  create_table "rides", force: :cascade do |t|
    t.bigint "amusement_park_id"
    t.string "name"
    t.integer "thrill_rating"
    t.boolean "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amusement_park_id"], name: "index_rides_on_amusement_park_id"
  end

  add_foreign_key "doctors", "hospitals"
  add_foreign_key "maintenances", "mechanics"
  add_foreign_key "maintenances", "rides"
  add_foreign_key "rides", "amusement_parks"
end