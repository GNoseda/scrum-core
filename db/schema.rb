# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_09_234429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "artifacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "artifact_type", null: false
    t.jsonb "content", default: {}, null: false
    t.datetime "created_at", null: false
    t.uuid "session_id", null: false
    t.string "status", default: "drafting", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_artifacts_on_session_id"
  end

  create_table "draft_artifacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "artifact_type", null: false
    t.datetime "created_at", null: false
    t.uuid "session_id", null: false
    t.jsonb "structured_content", null: false
    t.datetime "updated_at", null: false
    t.integer "version", null: false
    t.index ["session_id", "version"], name: "index_draft_artifacts_on_session_id_and_version", unique: true
    t.index ["session_id"], name: "index_draft_artifacts_on_session_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.jsonb "references", default: [], null: false
    t.integer "role", null: false
    t.uuid "session_id", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_messages_on_session_id"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "session_type", null: false
    t.string "status", default: "exploring", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "artifacts", "sessions"
  add_foreign_key "draft_artifacts", "sessions"
  add_foreign_key "messages", "sessions"
  add_foreign_key "sessions", "users"
end
