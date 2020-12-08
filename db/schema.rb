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

ActiveRecord::Schema.define(version: 2020_11_29_092813) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "end_user_id"
    t.integer "smoothie_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "end_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rule_violation_number", default: 0
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "end_user_id"
    t.integer "smoothie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.decimal "energy", precision: 13, scale: 9, default: "0.0"
    t.decimal "protein", precision: 13, scale: 9, default: "0.0"
    t.decimal "carb", precision: 13, scale: 9, default: "0.0"
    t.decimal "lipid", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_a", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_b1", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_b2", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_b6", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_b12", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_c", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_d", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_e", precision: 13, scale: 9, default: "0.0"
    t.decimal "vitamin_k", precision: 13, scale: 9, default: "0.0"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "juicer_ingredients", force: :cascade do |t|
    t.integer "end_user_id"
    t.integer "ingredient_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "smoothie_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smoothie_ingredients", force: :cascade do |t|
    t.integer "smoothie_id"
    t.integer "ingredient_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smoothies", force: :cascade do |t|
    t.integer "end_user_id"
    t.string "image_id"
    t.text "introduction"
    t.boolean "is_recommended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
