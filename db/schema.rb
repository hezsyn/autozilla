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

ActiveRecord::Schema.define(version: 20170420172711) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.string "is_enabled"
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
    t.text "loader_string"
    t.text "azk_loader_string"
    t.text "azk_up_loader_string"
    t.text "up_loader_string"
    t.text "azk_syslinux_loader_string"
    t.text "azk_syslinux_up_loader_string"
    t.text "azab_loader_string"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configurations", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "is_visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.text "description"
    t.string "disk"
    t.string "flags"
    t.string "flags_upload"
    t.string "path"
    t.string "loader_string"
    t.integer "user_id"
    t.integer "system_id"
    t.integer "pool_id"
    t.integer "ose_id"
    t.integer "image_status_id"
    t.integer "clonezilla_version_id"
    t.string "autoboot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clonezilla_version_id"], name: "index_images_on_clonezilla_version_id"
    t.index ["image_status_id"], name: "index_images_on_image_status_id"
    t.index ["ose_id"], name: "index_images_on_ose_id"
    t.index ["pool_id"], name: "index_images_on_pool_id"
    t.index ["system_id"], name: "index_images_on_system_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "ip_address"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "oses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pools", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "is_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.integer "is_enabled"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_systems_on_category_id"
  end

  create_table "templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
