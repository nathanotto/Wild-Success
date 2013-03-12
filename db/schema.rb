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

ActiveRecord::Schema.define(:version => 20130311182344) do

  create_table "clumps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "mission_id"
    t.string   "kind"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clumps", ["mission_id"], :name => "index_clumps_on_mission_id"
  add_index "clumps", ["user_id"], :name => "index_clumps_on_user_id"

  create_table "coactions", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "committed_user"
    t.date     "deadline"
    t.integer  "priority"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "position"
  end

  add_index "coactions", ["mission_id"], :name => "index_coactions_on_mission_id"
  add_index "coactions", ["user_id"], :name => "index_coactions_on_user_id"

  create_table "coactions_stickies", :id => false, :force => true do |t|
    t.integer "coaction_id"
    t.integer "sticky_id"
  end

  add_index "coactions_stickies", ["coaction_id", "sticky_id"], :name => "index_coactions_stickies_on_coaction_id_and_sticky_id"

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

  create_table "missions", :force => true do |t|
    t.string   "name"
    t.text     "blurb"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.boolean  "is_public"
  end

  create_table "stickies", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "clump_id"
    t.integer  "action_id"
    t.integer  "coaction_id"
    t.integer  "position"
  end

  add_index "stickies", ["action_id"], :name => "index_stickies_on_action_id"
  add_index "stickies", ["clump_id"], :name => "index_stickies_on_clump_id"
  add_index "stickies", ["coaction_id"], :name => "index_stickies_on_coaction_id"
  add_index "stickies", ["mission_id"], :name => "index_stickies_on_mission_id"
  add_index "stickies", ["user_id"], :name => "index_stickies_on_user_id"

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
