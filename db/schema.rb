# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_11_172140) do

  create_table "affiliations", force: :cascade do |t|
    t.integer "character_id"
    t.integer "nation_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "api_id"
    t.string "name"
    t.string "photo_url"
    t.boolean "is_avatar"
  end

  create_table "nations", force: :cascade do |t|
    t.string "name"
    t.string "shorthand"
    t.integer "leader_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "character_one_id"
    t.integer "character_two_id"
    t.boolean "are_enemies"
    t.boolean "are_allies"
  end

end
