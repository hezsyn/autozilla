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

ActiveRecord::Schema.define(version: 20170808203646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "autozilla_key_configs", force: :cascade do |t|
    t.string "btldr"
    t.string "purpose"
    t.string "kernal"
    t.string "boot"
    t.string "user_name"
    t.string "union"
    t.string "parameters_set1"
    t.string "edd"
    t.string "parameters_set2"
    t.string "keyboardLayout"
    t.string "ocs_prerun0"
    t.string "ocs_prerun1"
    t.string "ocs_prerun2"
    t.string "ocs_prerun3"
    t.string "ocs_prerun4"
    t.string "ocs_live_run"
    t.string "ocs_live_keymap"
    t.string "ocs_live_param"
    t.string "ocs_live_batch"
    t.string "ocs_repository"
    t.string "ocs_postrun0"
    t.string "ocs_postrun1"
    t.string "ocs_postrun2"
    t.string "ocs_postrun3"
    t.string "ocs_postrun4"
    t.string "locales"
    t.string "vga"
    t.string "ifname"
    t.string "parameters_set3"
    t.string "fetch"
    t.string "toram"
    t.string "live_media_path"
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
    t.bigint "grub_upload_id"
    t.bigint "grub_download_id"
    t.bigint "syslinux_upload_id"
    t.bigint "syslinux_download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grub_download_id"], name: "index_clonezilla_versions_on_grub_download_id"
    t.index ["grub_upload_id"], name: "index_clonezilla_versions_on_grub_upload_id"
    t.index ["syslinux_download_id"], name: "index_clonezilla_versions_on_syslinux_download_id"
    t.index ["syslinux_upload_id"], name: "index_clonezilla_versions_on_syslinux_upload_id"
  end

  create_table "configurations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.text "description"
    t.string "disk"
    t.string "flags"
    t.string "flags_upload"
    t.string "path"
    t.string "loader_string"
    t.string "file_location"
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
    t.bigint "grub_upload_id"
    t.bigint "grub_download_id"
    t.bigint "syslinux_upload_id"
    t.bigint "syslinux_download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clonezilla_version_id"], name: "index_images_on_clonezilla_version_id"
    t.index ["grub_download_id"], name: "index_images_on_grub_download_id"
    t.index ["grub_upload_id"], name: "index_images_on_grub_upload_id"
    t.index ["image_status_id"], name: "index_images_on_image_status_id"
    t.index ["image_type_id"], name: "index_images_on_image_type_id"
    t.index ["note_id"], name: "index_images_on_note_id"
    t.index ["ose_id"], name: "index_images_on_ose_id"
    t.index ["pool_id"], name: "index_images_on_pool_id"
    t.index ["syslinux_download_id"], name: "index_images_on_syslinux_download_id"
    t.index ["syslinux_upload_id"], name: "index_images_on_syslinux_upload_id"
    t.index ["system_id"], name: "index_images_on_system_id"
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

  create_table "systems", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.integer "is_enabled"
    t.string "file_location"
    t.string "default_disk"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_systems_on_category_id"
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
  end

end
