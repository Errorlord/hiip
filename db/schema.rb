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

ActiveRecord::Schema.define(version: 20160218112611) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "position"
    t.string   "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paths", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "position"
    t.integer  "level_position"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent"
  end

  create_table "structures", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.integer  "parent_position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trees", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tree_location"
    t.integer  "tree_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
