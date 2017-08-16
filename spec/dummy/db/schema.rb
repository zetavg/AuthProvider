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

ActiveRecord::Schema.define(version: 20170815134342) do

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "oauth_session_id", null: false
    t.text "token", null: false
    t.text "refresh_token"
    t.integer "expires_in", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["oauth_session_id"], name: "index_oauth_access_tokens_on_oauth_session_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["revoked_at"], name: "index_oauth_access_tokens_on_revoked_at"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_sessions", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.string "resource_owner_type", null: false
    t.string "device_name"
    t.string "device_type"
    t.text "device_identifier"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["device_type"], name: "index_oauth_sessions_on_device_type"
    t.index ["resource_owner_id"], name: "index_oauth_sessions_on_resource_owner_id"
    t.index ["resource_owner_type"], name: "index_oauth_sessions_on_resource_owner_type"
    t.index ["revoked_at"], name: "index_oauth_sessions_on_revoked_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.text "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
