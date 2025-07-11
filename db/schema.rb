# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_11_093444) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "full_name"
    t.integer "age"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "age_group_id"
    t.integer "organization_id"
    t.index ["age_group_id"], name: "index_accounts_on_age_group_id"
  end

  create_table "age_groups", force: :cascade do |t|
    t.string "name"
    t.integer "min_age"
    t.integer "max_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "audience"
    t.datetime "starts_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_analytics", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "metric"
    t.integer "value"
    t.datetime "recorded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_analytics_on_organization_id"
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_organization_memberships_on_account_id"
    t.index ["organization_id"], name: "index_organization_memberships_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "min_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parental_consents", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "parent_email"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_parental_consents_on_account_id"
  end

  add_foreign_key "organization_analytics", "organizations"
  add_foreign_key "organization_memberships", "accounts"
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "parental_consents", "accounts"
end
