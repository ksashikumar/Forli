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

ActiveRecord::Schema.define(version: 20170611142528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.text "description"
    t.integer "visibility", default: 0
    t.integer "level", default: 0
    t.integer "parent_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
    t.index ["visibility"], name: "index_categories_on_visibility"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.integer "level", default: 0
    t.integer "parent_id"
    t.bigint "user_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.text "title", null: false
    t.text "description", null: false
    t.bigint "user_id"
    t.integer "category_id"
    t.integer "upvotes_count", default: 0
    t.integer "downvotes_count", default: 0
    t.integer "posts_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "follows_count", default: 0
    t.integer "views", default: 0
    t.float "score", default: 0.0
    t.boolean "pinned", default: false
    t.boolean "locked", default: false
    t.boolean "published", default: false
    t.boolean "deleted", default: false
    t.boolean "spam", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_discussions_on_category_id"
    t.index ["deleted"], name: "index_discussions_on_deleted"
    t.index ["pinned"], name: "index_discussions_on_pinned"
    t.index ["published"], name: "index_discussions_on_published"
    t.index ["score"], name: "index_discussions_on_score"
    t.index ["spam"], name: "index_discussions_on_spam"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "discussion_id"
    t.integer "upvotes_count", default: 0
    t.integer "downvotes_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "views", default: 0
    t.float "score", default: 0.0
    t.boolean "deleted", default: false
    t.boolean "spam", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_posts_on_deleted"
    t.index ["discussion_id"], name: "index_posts_on_discussion_id"
    t.index ["score"], name: "index_posts_on_score"
    t.index ["spam"], name: "index_posts_on_spam"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.integer "count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "last_seen", null: false
    t.integer "karma", default: 0
    t.boolean "active", default: false
    t.integer "role", default: 0
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "discussions", "categories"
  add_foreign_key "discussions", "users"
  add_foreign_key "posts", "discussions"
  add_foreign_key "posts", "users"
end
