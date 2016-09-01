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

ActiveRecord::Schema.define(version: 20160509234228) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "picture"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "information"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.string   "school"
    t.integer  "year"
    t.string   "gradSeason"
    t.integer  "gradYear"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "hasPlace"
    t.string   "shared"
    t.integer  "budget"
    t.integer  "organization"
    t.integer  "cleanliness"
    t.integer  "party"
    t.integer  "drink"
    t.boolean  "drugs"
    t.boolean  "smoking"
    t.integer  "outgoing"
    t.integer  "numLogIns"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "avatar"
    t.text     "text"
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
  end

end
