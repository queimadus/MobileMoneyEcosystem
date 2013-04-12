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

ActiveRecord::Schema.define(:version => 20130402135720) do

  create_table "carts", :force => true do |t|
    t.integer  "client_id"
    t.boolean  "complete",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "image_url"
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "credit",     :default => 0
    t.date     "dob"
    t.string   "sex"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "quantity",     :default => 1
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "actual_price"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "limits", :force => true do |t|
    t.integer  "client_id"
    t.integer  "category_id"
    t.integer  "max"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "merchants", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "credit",       :default => 0
    t.string   "bank_account"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "merchant_id"
    t.boolean  "sent",        :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "merchant_id"
    t.string   "name"
    t.boolean  "available",                                        :default => true
    t.string   "image_url"
    t.decimal  "price",              :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "decimal",            :precision => 8, :scale => 2, :default => 0.0
    t.string   "qrcode"
    t.string   "reference"
    t.string   "brand"
    t.integer  "stock",                                            :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "transfers", :force => true do |t|
    t.integer  "client_id"
    t.integer  "amount"
    t.date     "date"
    t.string   "endpoint"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
