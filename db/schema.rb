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

ActiveRecord::Schema.define(version: 2019_04_26_143052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "join_table_message_recipients", force: :cascade do |t|
    t.bigint "private_message_id"
    t.bigint "recipient_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["private_message_id"], name: "index_join_table_message_recipients_on_private_message_id"
    t.index ["recipient_id"], name: "index_join_table_message_recipients_on_recipient_id"
  end

  create_table "private_messages", force: :cascade do |t|
    t.bigint "sender_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_private_messages_on_sender_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id"
    t.bigint "room_id"
    t.integer "nb_bed_rented"
    t.date "starting_date"
    t.date "ending_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "city_id"
    t.bigint "admin_id"
    t.integer "nb_bed"
    t.float "price_per_bed_pernight"
    t.boolean "has_wifi"
    t.text "description"
    t.text "welcome_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_rooms_on_admin_id"
    t.index ["city_id"], name: "index_rooms_on_city_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "city_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.string "phone_nb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_on_city_id"
  end

  add_foreign_key "join_table_message_recipients", "private_messages"
  add_foreign_key "reservations", "rooms"
end
