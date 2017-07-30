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

ActiveRecord::Schema.define(version: 20170730044223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admin_settings", force: :cascade do |t|
    t.string "type"
    t.boolean "enabled"
    t.hstore "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_admin_settings_on_type", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "discussion_id"
    t.integer "upvotes_count", default: 0
    t.integer "downvotes_count", default: 0
    t.integer "replies_count", default: 0
    t.integer "views", default: 0
    t.float "score", default: 0.0
    t.boolean "deleted", default: false
    t.boolean "spam", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_answers_on_deleted"
    t.index ["discussion_id"], name: "index_answers_on_discussion_id"
    t.index ["score"], name: "index_answers_on_score"
    t.index ["spam"], name: "index_answers_on_spam"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "automation_rules", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "match_all"
    t.integer "when"
    t.hstore "filter_data"
    t.hstore "action_data"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.text "description"
    t.integer "parent_id"
    t.integer "child_count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "discussion_tags", force: :cascade do |t|
    t.integer "discussion_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id", "tag_id"], name: "index_discussion_tags_on_discussion_id_and_tag_id", unique: true
    t.index ["discussion_id"], name: "index_discussion_tags_on_discussion_id"
    t.index ["tag_id"], name: "index_discussion_tags_on_tag_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.text "title", null: false
    t.text "description", null: false
    t.bigint "user_id"
    t.bigint "category_id"
    t.integer "upvotes_count", default: 0
    t.integer "downvotes_count", default: 0
    t.integer "answers_count", default: 0
    t.integer "follows_count", default: 0
    t.integer "views", default: 0
    t.float "score", default: 0.0
    t.boolean "locked", default: false
    t.boolean "published", default: false
    t.boolean "deleted", default: false
    t.boolean "spam", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sentiment", default: 0.0
    t.integer "correct_answer_id"
    t.index ["category_id"], name: "index_discussions_on_category_id"
    t.index ["deleted"], name: "index_discussions_on_deleted"
    t.index ["published"], name: "index_discussions_on_published"
    t.index ["score"], name: "index_discussions_on_score"
    t.index ["spam"], name: "index_discussions_on_spam"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "content"
    t.integer "notify_to"
    t.string "notifiable_type"
    t.bigint "discussion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_notifications_on_discussion_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "answer_id"
    t.boolean "spam", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_replies_on_answer_id"
    t.index ["spam"], name: "index_replies_on_spam"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.integer "count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_categories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_mentions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "mentionable_id"
    t.string "mentionable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentionable_id"], name: "index_user_mentions_on_mentionable_id"
    t.index ["mentionable_type"], name: "index_user_mentions_on_mentionable_type"
    t.index ["user_id"], name: "index_user_mentions_on_user_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notification_id"
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.datetime "last_seen"
    t.integer "karma"
    t.boolean "active"
    t.boolean "admin"
    t.boolean "deleted"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "preferences"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "answers", "discussions"
  add_foreign_key "answers", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "discussions", "categories"
  add_foreign_key "discussions", "users"
  add_foreign_key "notifications", "discussions"
  add_foreign_key "replies", "answers"
  add_foreign_key "replies", "users"
end
