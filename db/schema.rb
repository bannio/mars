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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130531101751) do

  create_table "addresses", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "body"
    t.string   "post_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "reference"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.string   "job_title"
    t.integer  "address_id"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "fax"
    t.string   "email"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["address_id"], :name => "index_contacts_on_address_id"
  add_index "contacts", ["company_id"], :name => "index_contacts_on_company_id"

  create_table "emails", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "subject"
    t.text     "body"
    t.string   "attachment"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "state"
    t.integer  "user_id"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "events", ["eventable_id", "eventable_type"], :name => "index_events_on_eventable_id_and_eventable_type"

  create_table "projects", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "company_id"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "completion_date"
    t.string   "status"
    t.integer  "value"
    t.text     "notes"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "purchase_order_lines", :force => true do |t|
    t.integer  "purchase_order_id"
    t.string   "name"
    t.text     "description"
    t.integer  "quantity"
    t.decimal  "unit_price",        :precision => 10, :scale => 2
    t.decimal  "total",             :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  add_index "purchase_order_lines", ["purchase_order_id"], :name => "index_purchase_order_lines_on_purchase_order_id"

  create_table "purchase_orders", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "customer_id"
    t.integer  "supplier_id"
    t.integer  "contact_id"
    t.date     "issue_date"
    t.text     "notes"
    t.integer  "address_id"
    t.string   "code"
    t.text     "description"
    t.integer  "delivery_address_id"
    t.string   "status"
    t.decimal  "total",               :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "client_id"
    t.date     "due_date"
  end

  add_index "purchase_orders", ["address_id"], :name => "index_purchase_orders_on_address_id"
  add_index "purchase_orders", ["contact_id"], :name => "index_purchase_orders_on_contact_id"
  add_index "purchase_orders", ["customer_id"], :name => "index_purchase_orders_on_customer_id"
  add_index "purchase_orders", ["project_id"], :name => "index_purchase_orders_on_project_id"
  add_index "purchase_orders", ["supplier_id"], :name => "index_purchase_orders_on_supplier_id"

  create_table "quotation_lines", :force => true do |t|
    t.integer  "quotation_id"
    t.string   "name"
    t.text     "description"
    t.integer  "quantity"
    t.decimal  "unit_price",   :precision => 10, :scale => 2
    t.decimal  "total",        :precision => 10, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "quotations", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "customer_id"
    t.integer  "supplier_id"
    t.integer  "contact_id"
    t.date     "issue_date"
    t.text     "notes"
    t.integer  "address_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "code"
    t.text     "description"
    t.integer  "delivery_address_id"
    t.string   "status"
    t.decimal  "total",               :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "sales_links", :force => true do |t|
    t.integer  "purchase_order_line_id"
    t.integer  "sales_order_line_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "sales_links", ["purchase_order_line_id"], :name => "index_sales_links_on_purchase_order_line_id"
  add_index "sales_links", ["sales_order_line_id"], :name => "index_sales_links_on_sales_order_line_id"

  create_table "sales_order_lines", :force => true do |t|
    t.integer  "sales_order_id"
    t.string   "name"
    t.text     "description"
    t.integer  "quantity"
    t.decimal  "unit_price",     :precision => 10, :scale => 2
    t.decimal  "total",          :precision => 10, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "sales_orders", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "customer_id"
    t.integer  "supplier_id"
    t.integer  "contact_id"
    t.date     "issue_date"
    t.text     "notes"
    t.integer  "address_id"
    t.string   "code"
    t.text     "description"
    t.integer  "delivery_address_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "status"
    t.decimal  "total",               :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles_mask"
    t.string   "full_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
