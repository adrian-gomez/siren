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

ActiveRecord::Schema.define(version: 20140908000642) do

  create_table "amenities", force: true do |t|
    t.string "description"
  end

  create_table "amenities_reservations", force: true do |t|
    t.integer "amenity_id"
    t.integer "reservation_id"
  end

  create_table "reservations", force: true do |t|
    t.string   "email",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "phone_number"
    t.string   "user_ip"
    t.date     "housing_date"
    t.string   "dark_wish"
    t.integer  "rating"
  end

end
