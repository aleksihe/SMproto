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

ActiveRecord::Schema.define(:version => 20121002090609) do

  create_table "bonuslevels", :force => true do |t|
    t.string   "kriteeri"
    t.integer  "ehto"
    t.integer  "bonus_maara"
    t.string   "laji"
    t.integer  "tasonro"
    t.integer  "salegroup_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.text     "kuvaus"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "salegroup_id"
  end

  create_table "competitions", :force => true do |t|
    t.string   "nimi"
    t.datetime "alku"
    t.datetime "loppu"
    t.integer  "palkintosijat"
    t.text     "saannot"
    t.integer  "logiikka"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "competitions_users", :force => true do |t|
    t.integer "user_id"
    t.integer "competition_id"
  end

  create_table "contacts", :force => true do |t|
    t.boolean  "tilaus"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "salegroup_id"
    t.string   "tekija"
  end

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "salegroup_id"
    t.string   "kohde"
    t.datetime "alku"
    t.datetime "loppu"
    t.string   "tyyppi"
    t.decimal  "maara"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "hinta"
    t.integer  "provisio"
    t.string   "kuvaus"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "prizes", :force => true do |t|
    t.integer  "competition_id"
    t.string   "kuvaus"
    t.decimal  "arvo"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "products", :force => true do |t|
    t.text     "kuvaus"
    t.integer  "hinta"
    t.integer  "provisio"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "salegroups", :force => true do |t|
    t.string   "nimi"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  create_table "users", :force => true do |t|
    t.string   "nimi"
    t.string   "tunnus"
    t.string   "password_digest"
    t.boolean  "esimies"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "salegroup_id"
    t.boolean  "online"
  end

end
