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

ActiveRecord::Schema.define(:version => 20130117050016) do

  create_table "assumptions", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assumptions", ["mission_id"], :name => "index_assumptions_on_mission_id"

  create_table "constraints", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "constraints", ["mission_id"], :name => "index_constraints_on_mission_id"

  create_table "drivers", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "drivers", ["mission_id"], :name => "index_drivers_on_mission_id"

  create_table "facts", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "facts", ["mission_id"], :name => "index_facts_on_mission_id"

  create_table "missions", :force => true do |t|
    t.string   "name"
    t.text     "blurb"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "wild_successes", :force => true do |t|
    t.string   "success"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wild_successes", ["mission_id"], :name => "index_wild_successes_on_mission_id"

end
