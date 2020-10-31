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

ActiveRecord::Schema.define(version: 2020_10_31_100633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "website", default: ""
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "company_submissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "website", default: ""
    t.integer "tool_ids", default: [], array: true
    t.string "unknown_tools", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stack_entries", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "tool_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "community", default: false
    t.integer "community_endorsements", default: 0
    t.index ["company_id", "tool_id"], name: "index_stacks_on_company_and_tool", unique: true
    t.index ["company_id"], name: "index_stack_entries_on_company_id"
    t.index ["tool_id"], name: "index_stack_entries_on_tool_id"
  end

  create_table "tool_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tool_categories_on_name"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", default: ""
    t.string "website", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tool_category_id"
    t.index ["name"], name: "index_tools_on_name"
    t.index ["tool_category_id"], name: "index_tools_on_tool_category_id"
  end

  add_foreign_key "stack_entries", "companies"
  add_foreign_key "stack_entries", "tools"
  add_foreign_key "tools", "tool_categories"

  create_view "popular_tools", materialized: true, sql_definition: <<-SQL
      SELECT tools.id AS tool_id,
      count(tools.id) AS popularity,
      tools.tool_category_id
     FROM (stack_entries
       JOIN tools ON ((tools.id = stack_entries.tool_id)))
    GROUP BY tools.id
    ORDER BY (count(tools.id)) DESC;
  SQL
  add_index "popular_tools", ["tool_id"], name: "index_popular_tools_on_tool_id"

  create_view "company_popular_tools", materialized: true, sql_definition: <<-SQL
      SELECT company_popular_tools.company_id,
      company_popular_tools.tool_id,
      company_popular_tools.popularity,
      company_popular_tools.rank
     FROM ( SELECT companies.id AS company_id,
              popular_tools.tool_id,
              popular_tools.popularity,
              rank() OVER (PARTITION BY companies.id ORDER BY popular_tools.popularity DESC) AS rank
             FROM (((companies
               JOIN stack_entries ON ((stack_entries.company_id = companies.id)))
               JOIN popular_tools ON ((stack_entries.tool_id = popular_tools.tool_id)))
               JOIN tool_categories ON ((tool_categories.id = popular_tools.tool_category_id)))
            WHERE (((tool_categories.name)::text = 'Language'::text) OR ((tool_categories.name)::text = 'Framework'::text))) company_popular_tools
    WHERE (company_popular_tools.rank = 1);
  SQL
  add_index "company_popular_tools", ["company_id"], name: "index_company_popular_tools_on_company_id"

end
