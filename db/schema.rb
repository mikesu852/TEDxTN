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

ActiveRecord::Schema.define(version: 20160422135819) do

  create_table "activities", force: :cascade do |t|
    t.string   "title"
    t.integer  "views",      default: 0
    t.string   "category"
    t.string   "place"
    t.datetime "date"
    t.string   "thumb"
    t.text     "content"
    t.text     "summary"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.integer  "user_id"
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.integer  "views",      default: 0
    t.string   "category"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "content"
    t.string   "thumb"
    t.text     "intro"
    t.text     "summary"
    t.integer  "status",     default: 0
    t.integer  "user_id"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "films", force: :cascade do |t|
    t.string   "title"
    t.integer  "views",      default: 0
    t.string   "year"
    t.string   "event"
    t.text     "summary"
    t.string   "url"
    t.string   "category"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
  end

  add_index "films", ["user_id"], name: "index_films_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "profile"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar"
  end

end
