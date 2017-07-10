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

ActiveRecord::Schema.define(version: 20170704143548) do

  create_table "book_user_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_user_ratings", ["book_id"], name: "index_book_user_ratings_on_book_id"
  add_index "book_user_ratings", ["user_id"], name: "index_book_user_ratings_on_user_id"

  create_table "book_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "list_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_users", ["book_id"], name: "index_book_users_on_book_id"
  add_index "book_users", ["user_id"], name: "index_book_users_on_user_id"

  create_table "books", force: :cascade do |t|
    t.string   "title",           default: "Название", null: false
    t.string   "author",          default: "Автор",    null: false
    t.text     "description",     default: "Описание", null: false
    t.string   "cover_picture"
    t.integer  "user_id"
    t.string   "genre",           default: "Жанр",     null: false
    t.boolean  "best_month",      default: false,      null: false
    t.datetime "best_month_date"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.integer  "age"
    t.string   "email",                  default: "", null: false
    t.string   "avatar"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
