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
    t.string  "slug"
    t.boolean "public"
  end

  add_index "conversations", ["slug"], name: "index_conversations_on_slug", unique: true

  create_table "messages", force: true do |t|
    t.text     "text"
    t.integer  "author_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
  end

  create_table "user_conversations", force: true do |t|
    t.integer "user_id"
    t.integer "conversation_id"
    t.integer "start_from",      default: 0
  end

  add_index "user_conversations", ["conversation_id"], name: "index_user_conversations_on_conversation_id"
  add_index "user_conversations", ["start_from"], name: "index_user_conversations_on_start_from"
  add_index "user_conversations", ["user_id"], name: "index_user_conversations_on_user_id"

  create_table "users", force: true do |t|
    t.string "name"
    t.string "token"
  end

  add_foreign_key "messages", "conversations", :name => "messages_conversation_id_fk", :dependent => :delete

  add_foreign_key "user_conversations", "conversations", :name => "user_conversations_conversation_id_fk", :dependent => :delete
  add_foreign_key "user_conversations", "users", :name => "user_conversations_user_id_fk", :dependent => :delete

end
