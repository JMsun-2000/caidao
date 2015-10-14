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

ActiveRecord::Schema.define(version: 20151014132005) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_infos", force: true do |t|
    t.integer  "user_id"
    t.string   "real_name"
    t.text     "comment_info"
    t.integer  "phone_number"
    t.string   "resturant_address"
    t.integer  "identify_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price",        precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit",                                 default: "公斤"
    t.string   "origin",                               default: "本地"
    t.integer  "inventory",                            default: 0
    t.string   "product_type",                         default: "蔬菜"
    t.string   "sub_type"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",        default: 0
  end

end
