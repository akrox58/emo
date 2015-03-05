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

ActiveRecord::Schema.define(version: 20150305124409) do

  create_table "artists", force: :cascade do |t|
    t.integer  "song_id"
    t.string   "artistname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "artists", ["song_id"], name: "index_artists_on_song_id"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.string   "mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moods", force: :cascade do |t|
    t.integer  "song_id"
    t.string   "moodname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "moods", ["song_id"], name: "index_moods_on_song_id"

  create_table "playlists", force: :cascade do |t|
    t.integer  "mood_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "song_id"
    t.string   "name"
  end

  add_index "playlists", ["mood_id"], name: "index_playlists_on_mood_id"
  add_index "playlists", ["song_id"], name: "index_playlists_on_song_id"
  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id"

  create_table "populars", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "populars", ["song_id"], name: "index_populars_on_song_id"

  create_table "raters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "search"
    t.integer  "mood_id"
    t.integer  "play"
  end

  add_index "raters", ["mood_id"], name: "index_raters_on_mood_id"
  add_index "raters", ["song_id"], name: "index_raters_on_song_id"
  add_index "raters", ["user_id"], name: "index_raters_on_user_id"

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.integer  "mood_id"
    t.integer  "artist_id"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id"
  add_index "songs", ["mood_id"], name: "index_songs_on_mood_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
