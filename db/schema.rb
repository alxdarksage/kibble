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

ActiveRecord::Schema.define(:version => 20140403044319) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.decimal  "value"
    t.decimal  "enc"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "rules_validate",   :default => true
    t.decimal  "calculated_value"
    t.decimal  "calculated_enc"
  end

  create_table "items_tags", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "tag_id"
  end

  create_table "professions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "function"
  end

  create_table "professions_seeds", :id => false, :force => true do |t|
    t.integer "profession_id"
    t.integer "tag_id"
  end

  create_table "professions_tags", :id => false, :force => true do |t|
    t.integer "profession_id"
    t.integer "tag_id"
  end

  create_table "professions_traits", :id => false, :force => true do |t|
    t.integer "profession_id"
    t.integer "tag_id"
  end

  create_table "rules", :force => true do |t|
    t.string   "identifier"
    t.text     "parameters"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "policy"
    t.string   "owner_profession"
    t.string   "owner_trait"
    t.string   "bag_query"
    t.integer  "bag_total_value"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "stores_tags", :id => false, :force => true do |t|
    t.integer "store_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "category"
    t.text     "description"
    t.string   "rel",         :default => "item"
  end

end
