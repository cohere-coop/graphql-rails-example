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

ActiveRecord::Schema.define(version: 2018_07_24_183935) do

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "identifier", null: false
    t.string "type", default: "Identity"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "task_list_memberships", force: :cascade do |t|
    t.integer "task_list_id", null: false
    t.integer "user_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_list_id"], name: "index_task_list_memberships_on_task_list_id"
    t.index ["user_id"], name: "index_task_list_memberships_on_user_id"
  end

  create_table "task_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks_task_lists", force: :cascade do |t|
    t.integer "task_id"
    t.integer "task_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_tasks_task_lists_on_task_id"
    t.index ["task_list_id"], name: "index_tasks_task_lists_on_task_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "users_tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_users_tasks_on_task_id"
    t.index ["user_id"], name: "index_users_tasks_on_user_id"
  end

end
