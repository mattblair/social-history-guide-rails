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

ActiveRecord::Schema.define(:version => 20130821144658) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
    t.string   "human_name"
    t.string   "username"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admin_users_roles", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "role_id"
  end

  add_index "admin_users_roles", ["admin_user_id", "role_id"], :name => "index_admin_users_roles_on_admin_user_id_and_role_id"

  create_table "collections", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "author"
    t.string   "geographical_title"
    t.text     "geographical_scope"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "published"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "sponsor_name"
    t.text     "sponsor_description"
    t.string   "sponsor_logo_name"
    t.text     "sponsor_url"
    t.string   "curator_name"
    t.text     "curator_url"
  end

  create_table "guests", :force => true do |t|
    t.string   "name",                    :default => "",    :null => false
    t.string   "title"
    t.string   "organization"
    t.string   "image_name"
    t.text     "bio"
    t.string   "twitter_template"
    t.text     "editorial_notes"
    t.text     "quote"
    t.string   "guest_url"
    t.string   "guest_url_text"
    t.integer  "workflow_state_id",       :default => 1
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "display_order",           :default => 50
    t.text     "specialty"
    t.string   "image_credit"
    t.text     "image_credit_url"
    t.string   "image_copyright_notice"
    t.text     "image_copyright_url"
    t.text     "image_copyright_details"
    t.boolean  "release_confirmed",       :default => false
    t.string   "slug"
    t.integer  "proofreader_id"
  end

  add_index "guests", ["slug"], :name => "index_guests_on_slug", :unique => true

  create_table "image_statuses", :force => true do |t|
    t.string   "name"
    t.string   "human_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media_types", :force => true do |t|
    t.string   "human_name"
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "summary"
    t.string   "audio_filename"
    t.string   "original_audio_filename"
    t.string   "image_name"
    t.string   "image_credit"
    t.string   "thumbnail_name"
    t.string   "twitter_template"
    t.text     "editorial_notes"
    t.integer  "editing_priority",        :default => 50
    t.text     "audio_transcription"
    t.integer  "display_order",           :default => 50
    t.string   "keywords"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "workflow_state_id",       :default => 1
    t.integer  "collection_id",           :default => 1
    t.integer  "theme_id"
    t.integer  "guest_id"
    t.integer  "media_type_id",           :default => 1
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.text     "image_credit_url"
    t.string   "image_copyright_notice"
    t.text     "image_copyright_url"
    t.text     "image_copyright_details"
    t.string   "slug"
    t.text     "photo_notes"
    t.integer  "proofreader_id"
    t.string   "more_info_url"
    t.string   "more_info_title"
    t.text     "more_info_description"
    t.text     "more_info_notes"
    t.text     "map_data"
    t.integer  "map_data_type",           :default => 0
    t.string   "image_caption"
    t.boolean  "location_valid",          :default => false
    t.boolean  "image_usage_cleared",     :default => false
    t.integer  "image_status_id",         :default => 1
  end

  add_index "stories", ["slug"], :name => "index_stories_on_slug", :unique => true

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "summary"
    t.string   "image_name"
    t.string   "image_credit"
    t.string   "twitter_template"
    t.text     "editorial_notes"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "display_order"
    t.string   "keywords"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "workflow_state_id",       :default => 1
    t.text     "image_credit_url"
    t.string   "image_copyright_notice"
    t.text     "image_copyright_url"
    t.text     "image_copyright_details"
    t.string   "slug"
    t.integer  "proofreader_id"
    t.text     "map_data"
    t.integer  "map_data_type"
    t.boolean  "display_in_story_list",   :default => true
    t.boolean  "display_in_tidbit_list",  :default => true
  end

  add_index "themes", ["slug"], :name => "index_themes_on_slug", :unique => true

  create_table "tidbits", :force => true do |t|
    t.string   "title"
    t.string   "year"
    t.datetime "publication_date"
    t.string   "twitter_template"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "editorial_notes"
    t.string   "image_name"
    t.string   "image_caption"
    t.string   "image_credit"
    t.text     "body"
    t.string   "audio_filename"
    t.string   "source"
    t.text     "source_url"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "workflow_state_id",       :default => 1
    t.integer  "media_type_id",           :default => 3
    t.integer  "collection_id",           :default => 1
    t.integer  "theme_id"
    t.text     "image_credit_url"
    t.string   "image_copyright_notice"
    t.text     "image_copyright_url"
    t.text     "image_copyright_details"
    t.string   "media_copyright_notice"
    t.text     "media_copyright_url"
    t.text     "media_copyright_details"
    t.string   "slug"
    t.text     "photo_notes"
    t.integer  "proofreader_id"
    t.string   "more_info_url"
    t.string   "more_info_title"
    t.text     "more_info_description"
    t.text     "more_info_notes"
    t.text     "map_data"
    t.integer  "map_data_type",           :default => 0
    t.boolean  "location_valid",          :default => false
  end

  add_index "tidbits", ["slug"], :name => "index_tidbits_on_slug", :unique => true

  create_table "users", :force => true do |t|
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
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "workflow_states", :force => true do |t|
    t.string   "state_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
