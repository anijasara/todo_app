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

ActiveRecord::Schema.define(version: 2020_11_27_105948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "list_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_id"
    t.text "name"
    t.text "description"
    t.string "status"
    t.datetime "done_at"
    t.datetime "due_at"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "template_lists", force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_template_lists_on_list_id"
    t.index ["template_id"], name: "index_template_lists_on_template_id"
  end

  create_table "template_tasks", force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_template_tasks_on_task_id"
    t.index ["template_id"], name: "index_template_tasks_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "template_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tasks", "lists"
  add_foreign_key "template_lists", "lists"
  add_foreign_key "template_lists", "templates"
  add_foreign_key "template_tasks", "tasks"
  add_foreign_key "template_tasks", "templates"
end
