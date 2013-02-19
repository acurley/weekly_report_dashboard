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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130219142002) do

  create_table "alternate_names", :force => true do |t|
    t.integer  "property_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.integer  "total_units"
    t.integer  "phases"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stats", :force => true do |t|
    t.integer  "property_id"
    t.date     "date_retrieved"
    t.integer  "current_occupied"
    t.integer  "total_vacants"
    t.integer  "vacant_rented"
    t.integer  "vacant_unrented"
    t.float    "percent_occupied"
    t.float    "percent_preleased"
    t.integer  "total_guest_cards"
    t.integer  "total_apps"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end