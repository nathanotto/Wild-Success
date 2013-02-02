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

ActiveRecord::Schema.define(:version => 20130202170009) do

  create_table "assumptions", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "assumptions", ["mission_id"], :name => "index_assumptions_on_mission_id"
  add_index "assumptions", ["user_id"], :name => "index_assumptions_on_user_id"

  create_table "collaborators", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "user_id"
    t.string   "permission"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "confirmed"
  end

  add_index "collaborators", ["mission_id"], :name => "index_collaborators_on_mission_id"
  add_index "collaborators", ["user_id"], :name => "index_collaborators_on_user_id"

  create_table "constraints", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "constraints", ["mission_id"], :name => "index_constraints_on_mission_id"
  add_index "constraints", ["user_id"], :name => "index_constraints_on_user_id"

  create_table "drivers", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "drivers", ["mission_id"], :name => "index_drivers_on_mission_id"
  add_index "drivers", ["user_id"], :name => "index_drivers_on_user_id"

  create_table "facts", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "facts", ["mission_id"], :name => "index_facts_on_mission_id"
  add_index "facts", ["user_id"], :name => "index_facts_on_user_id"

  create_table "missions", :force => true do |t|
    t.string   "name"
    t.text     "blurb"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.boolean  "is_public"
  end

  create_table "successes", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "successes", ["mission_id"], :name => "index_successes_on_mission_id"
  add_index "successes", ["user_id"], :name => "index_successes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
