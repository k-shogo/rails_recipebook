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

ActiveRecord::Schema.define(version: 20140826085303) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "presentation_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "place_id"
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "postcode"
    t.string   "prefecture"
    t.string   "address"
    t.decimal  "latitude",   precision: 20, scale: 15
    t.decimal  "longitude",  precision: 20, scale: 15
    t.integer  "zoom_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", force: true do |t|
    t.integer  "event_id"
    t.integer  "category_id"
    t.string   "uuid",        null: false
    t.string   "title"
    t.text     "description"
    t.string   "video"
    t.string   "video_tmp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "presentations", ["uuid"], name: "index_presentations_on_uuid", unique: true, using: :btree

  create_table "transcodes", force: true do |t|
    t.integer  "presentation_id"
    t.string   "job_id"
    t.string   "arn"
    t.string   "pipeline_id"
    t.string   "input_key"
    t.string   "frame_rate"
    t.string   "resolution"
    t.string   "aspect_ratio"
    t.string   "interlaced"
    t.string   "container"
    t.string   "output_key_prefix"
    t.string   "output_key"
    t.string   "thumbnail_pattern"
    t.string   "rotate"
    t.string   "preset_id"
    t.integer  "duration"
    t.integer  "width"
    t.integer  "height"
    t.string   "status"
    t.text     "status_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
