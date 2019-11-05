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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2019_11_05_172308) do
=======
ActiveRecord::Schema.define(version: 2019_11_03_155519) do
>>>>>>> d43462e55b6700e7fd68c3c8b18b63ef1c83d1e3

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phoneNumber"
    t.string "address"
    t.string "postalCode"
    t.string "local"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counter"
<<<<<<< HEAD
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
=======
    t.string "link"
    t.string "avatar"
>>>>>>> d43462e55b6700e7fd68c3c8b18b63ef1c83d1e3
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
