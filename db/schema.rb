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

ActiveRecord::Schema.define(version: 20170307162712) do

  create_table "candidate_session_question_groups", force: :cascade do |t|
    t.integer  "candidate_session_id", limit: 4
    t.integer  "question_group_id",    limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "candidate_session_question_groups", ["candidate_session_id"], name: "index_candidate_session_question_groups_on_candidate_session_id", using: :btree
  add_index "candidate_session_question_groups", ["question_group_id"], name: "index_candidate_session_question_groups_on_question_group_id", using: :btree

  create_table "candidate_sessions", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "is_active"
  end

  add_index "candidate_sessions", ["user_id"], name: "index_candidate_sessions_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.integer  "question_limit", limit: 4
    t.integer  "question_score", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "options", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.integer  "question_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "is_correct"
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "question_groups", force: :cascade do |t|
    t.text     "description",    limit: 65535
    t.integer  "category_id",    limit: 4
    t.integer  "level_id",       limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "question_count", limit: 4,     default: 1
  end

  add_index "question_groups", ["category_id"], name: "index_question_groups_on_category_id", using: :btree
  add_index "question_groups", ["level_id"], name: "index_question_groups_on_level_id", using: :btree
  add_index "question_groups", ["question_count"], name: "idx_qcount_on_qgroups", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "description",       limit: 65535
    t.integer  "option_count",      limit: 4
    t.integer  "level_id",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "question_group_id", limit: 4
    t.text     "explanation",       limit: 65535
  end

  add_index "questions", ["level_id"], name: "index_questions_on_level_id", using: :btree

  create_table "session_question_group_questions", force: :cascade do |t|
    t.integer  "candidate_session_question_group_id", limit: 4
    t.integer  "question_id",                         limit: 4
    t.integer  "option_id",                           limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "question_number",                     limit: 4
  end

  add_index "session_question_group_questions", ["candidate_session_question_group_id"], name: "inx_ses_que_gr_que_on_can_ses_que_gr_id", using: :btree
  add_index "session_question_group_questions", ["option_id"], name: "index_session_question_group_questions_on_option_id", using: :btree
  add_index "session_question_group_questions", ["question_id"], name: "index_session_question_group_questions_on_question_id", using: :btree
  add_index "session_question_group_questions", ["question_number"], name: "inx_qno_on_ses_que_gr_que", using: :btree

  create_table "session_questions", force: :cascade do |t|
    t.integer  "candidate_session_id", limit: 4
    t.integer  "question_id",          limit: 4
    t.integer  "option_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "session_questions", ["candidate_session_id"], name: "index_session_questions_on_candidate_session_id", using: :btree
  add_index "session_questions", ["option_id"], name: "index_session_questions_on_option_id", using: :btree
  add_index "session_questions", ["question_id"], name: "index_session_questions_on_question_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "candidate_session_question_groups", "candidate_sessions"
  add_foreign_key "candidate_session_question_groups", "question_groups"
  add_foreign_key "candidate_sessions", "users"
  add_foreign_key "options", "questions"
  add_foreign_key "question_groups", "categories"
  add_foreign_key "question_groups", "levels"
  add_foreign_key "questions", "levels"
  add_foreign_key "session_question_group_questions", "candidate_session_question_groups"
  add_foreign_key "session_question_group_questions", "options"
  add_foreign_key "session_question_group_questions", "questions"
  add_foreign_key "session_questions", "candidate_sessions"
  add_foreign_key "session_questions", "options"
  add_foreign_key "session_questions", "questions"
end
