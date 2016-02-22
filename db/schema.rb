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

ActiveRecord::Schema.define(version: 20160222095907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.string   "suit"
    t.string   "face"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_cards", force: true do |t|
    t.integer  "game_id"
    t.integer  "card_id"
    t.integer  "user_id"
    t.string   "step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_cards", ["game_id", "card_id", "user_id"], name: "index_game_cards_on_game_id_and_card_id_and_user_id", using: :btree

  create_table "games", force: true do |t|
    t.string   "result"
    t.integer  "user_id"
    t.integer  "final_score"
    t.integer  "winner_score"
    t.integer  "looser_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["user_id"], name: "index_games_on_user_id", using: :btree

  create_table "user_games", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_games", ["game_id", "user_id"], name: "index_user_games_on_game_id_and_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_dealer",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
