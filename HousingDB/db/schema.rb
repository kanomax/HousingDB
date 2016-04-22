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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140222172317) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "companyname"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "cellphone"
  end

  create_table "housefiles", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "house_id"
  end

  create_table "houses", :force => true do |t|
    t.string   "address"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "county"
    t.integer  "lotsize"
    t.integer  "squarefeet"
    t.decimal  "bedrooms",              :precision => 4, :scale => 2
    t.decimal  "bathrooms"
    t.string   "style"
    t.integer  "year"
    t.integer  "basementsf"
    t.integer  "basementsffinish"
    t.decimal  "basementbd",            :precision => 4, :scale => 2
    t.decimal  "basementbath",          :precision => 4, :scale => 2
    t.text     "basementother"
    t.string   "garagestalls"
    t.string   "heating"
    t.string   "cooling"
    t.string   "siding"
    t.boolean  "replwindows"
    t.string   "outbuilding"
    t.decimal  "fireplaces",            :precision => 4, :scale => 2
    t.decimal  "woodstoves",            :precision => 4, :scale => 2
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
  end

  create_table "listings", :force => true do |t|
    t.string   "listingprice"
    t.date     "listingdate"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "house_id"
    t.integer  "agent_id"
  end

  create_table "sales", :force => true do |t|
    t.integer  "price"
    t.date     "saledate"
    t.date     "contractprice"
    t.string   "concession"
    t.string   "specialterms"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "house_id"
    t.integer  "agent_id"
    t.integer  "dom"
  end

end
