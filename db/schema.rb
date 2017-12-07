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

ActiveRecord::Schema.define(version: 20171207004726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "autozilla_key_configs", force: :cascade do |t|
    t.string "purpose"
    t.string "params_set"
    t.string "edd"
    t.string "prerun0"
    t.string "prerun1"
    t.string "prerun2"
    t.string "prerun3"
    t.string "prerun4"
    t.string "live_run"
    t.string "live_keymap"
    t.string "live_param"
    t.string "live_batch"
    t.string "repository"
    t.string "postrun0"
    t.string "postrun1"
    t.string "postrun2"
    t.string "postrun3"
    t.string "postrun4"
    t.string "locales"
    t.string "flags"
    t.string "loader_string"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.string "is_enabled"
    t.string "file_location"
    t.integer "user_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "clonezilla_versions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "is_enabled"
    t.integer "default"
    t.bigint "upload_id"
    t.bigint "download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["download_id"], name: "index_clonezilla_versions_on_download_id"
    t.index ["upload_id"], name: "index_clonezilla_versions_on_upload_id"
  end

  create_table "image_statuses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "is_visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "azkName"
    t.text "description"
    t.string "file_location"
    t.string "server_location"
    t.string "disk"
    t.bigint "note_id"
    t.bigint "user_id"
    t.bigint "system_id"
    t.bigint "pool_id"
    t.bigint "ose_id"
    t.bigint "image_status_id"
    t.bigint "clonezilla_version_id"
    t.bigint "image_type_id"
    t.string "autoboot"
    t.integer "current"
    t.bigint "upload_id"
    t.bigint "download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clonezilla_version_id"], name: "index_images_on_clonezilla_version_id"
    t.index ["download_id"], name: "index_images_on_download_id"
    t.index ["image_status_id"], name: "index_images_on_image_status_id"
    t.index ["image_type_id"], name: "index_images_on_image_type_id"
    t.index ["note_id"], name: "index_images_on_note_id"
    t.index ["ose_id"], name: "index_images_on_ose_id"
    t.index ["pool_id"], name: "index_images_on_pool_id"
    t.index ["system_id"], name: "index_images_on_system_id"
    t.index ["upload_id"], name: "index_images_on_upload_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "logs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "ip_address"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "information"
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_notes_on_image_id"
  end

  create_table "oses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pools", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string "whatSearch"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "support_stuffs", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.integer "is_enabled"
    t.string "file_location"
    t.string "default_disk"
    t.integer "category_id"
    t.integer "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_systems_on_category_id"
    t.index ["note_id"], name: "index_systems_on_note_id"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.integer "is_domain_login"
    t.string "slug"
    t.string "password"
    t.string "email"
    t.date "last_login"
    t.string "role"
    t.integer "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

end
