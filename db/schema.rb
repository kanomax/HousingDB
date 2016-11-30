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

ActiveRecord::Schema.define(version: 20161130012318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "name"
    t.string   "companyname"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "cellphone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "agents", ["listing_id"], name: "index_agents_on_listing_id", using: :btree

  create_table "housefiles", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "file_name"
    t.string   "file_content_type"
    t.integer  "file_size"
    t.integer  "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "housefiles", ["house_id"], name: "index_housefiles_on_house_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "county"
    t.integer  "lotsize"
    t.integer  "squarefeet"
    t.decimal  "bedrooms",              precision: 4, scale: 2
    t.decimal  "bathrooms"
    t.string   "style"
    t.integer  "year"
    t.integer  "basementsf"
    t.integer  "basementsffinish"
    t.decimal  "basementbd",            precision: 4, scale: 2
    t.decimal  "basementbath",          precision: 4, scale: 2
    t.text     "basementother"
    t.string   "garagestalls"
    t.string   "heating"
    t.string   "cooling"
    t.string   "siding"
    t.boolean  "replwindows"
    t.string   "outbuilding"
    t.decimal  "fireplaces",            precision: 4, scale: 2
    t.decimal  "woodstoves",            precision: 4, scale: 2
    t.string   "gencomments"
    t.string   "status"
    t.integer  "currentprice"
    t.string   "condition"
    t.string   "quality"
    t.boolean  "concretedrive"
    t.boolean  "sprinklers"
    t.integer  "parcel_id"
    t.text     "attachments"
    t.string   "houseimg_file_name"
    t.string   "houseimg_content_type"
    t.integer  "houseimg_file_size"
    t.datetime "houseimg_updated_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "agent_id"
    t.integer  "listingprice"
    t.date     "listingdate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "agent_id"
    t.integer  "price"
    t.date     "saledate"
    t.integer  "contractprice"
    t.string   "concession"
    t.string   "specialterms"
    t.integer  "dom"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "book"
    t.integer  "page"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
