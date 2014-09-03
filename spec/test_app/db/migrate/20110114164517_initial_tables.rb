# Adds tables for the base application we brought to the competition.
# origin: RM
class InitialTables < ActiveRecord::Migration

  def self.up

    create_table "taggings", :force => true do |t|
      t.integer  "tag_id"
      t.integer  "taggable_id"
      t.integer  "tagger_id"
      t.string   "tagger_type"
      t.string   "taggable_type"
      t.string   "context"
      t.datetime "created_at"
    end

    add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
    add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

    create_table "tags", :force => true do |t|
      t.string "name"
    end

    create_table "users", :force => true do |t|
      t.string   "email"
      t.string   "encrypted_password"
      t.string   "salt"
      t.string   "confirmation_token"
      t.string   "remember_token"
      t.boolean  "email_confirmed"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "full_name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "role_name"
      t.boolean  "locked"
      t.boolean  "deleted"
    end

    add_index "users", ["email"], :unique => true

  end

  def self.down

    drop_table 'taggings'
    drop_table 'tags'
    drop_table 'users'

  end
end
