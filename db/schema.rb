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

ActiveRecord::Schema.define(version: 20140110195806) do

  create_table "calls", force: true do |t|
    t.string   "call_id"
    t.string   "call_type"
    t.string   "address"
    t.string   "agency"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "updated_at", limit: 255
    t.datetime "created_at"
    t.string   "zip"
  end

  create_table "searches", force: true do |t|
    t.string   "address"
    t.string   "zip"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
