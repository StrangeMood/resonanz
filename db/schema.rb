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

ActiveRecord::Schema.define(version: 20130324095325) do

  create_table "conversations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.integer  "author_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.integer  "start_from",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_conversations", ["conversation_id"], name: "index_user_conversations_on_conversation_id"
  add_index "user_conversations", ["start_from"], name: "index_user_conversations_on_start_from"
  add_index "user_conversations", ["user_id"], name: "index_user_conversations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
