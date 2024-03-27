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

ActiveRecord::Schema.define(version: 2024_03_27_010614) do

  create_table "tic_tac_toe_boards", force: :cascade do |t|
    t.string "a1"
    t.string "a2"
    t.string "a3"
    t.string "b1"
    t.string "b2"
    t.string "b3"
    t.string "c1"
    t.string "c2"
    t.string "c3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "game_state", default: "ongoing"
  end

  create_table "tic_tac_toe_players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tic_tac_toe_board_id"
    t.string "initial"
    t.boolean "is_winners"
    t.boolean "give_up"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: false
    t.index ["tic_tac_toe_board_id"], name: "index_tic_tac_toe_players_on_tic_tac_toe_board_id"
    t.index ["user_id"], name: "index_tic_tac_toe_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player"
  end

end
