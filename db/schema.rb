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

ActiveRecord::Schema.define(version: 20170614163652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "restaurant_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_restaurant_tags_on_restaurant_id"
    t.index ["tag_id", "restaurant_id"], name: "index_restaurant_tags_on_tag_id_and_restaurant_id", unique: true
    t.index ["tag_id"], name: "index_restaurant_tags_on_tag_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.integer "walking_minutes_away", null: false
    t.string "street_address", null: false
    t.string "phone_number"
    t.string "menu_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["walking_minutes_away"], name: "index_restaurants_on_walking_minutes_away"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end
end
