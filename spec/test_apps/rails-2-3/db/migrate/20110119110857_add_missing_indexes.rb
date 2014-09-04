# Adds indexes to some tables to speed up the application when many records are present.
# origin: M
class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :users, :remember_token
    add_index :users, :deleted
    add_index :friendship_requests, :user_id
    add_index :invitations, :recipient_id
    add_index :friendships, :user_id
    add_index :conference_categories, :category_id
    add_index :conference_categories, :conference_id
  end

  def self.down
    remove_index :users, :remember_token
    remove_index :users, :deleted
    remove_index :friendship_requests, :user_id
    remove_index :invitations, :recipient_id
    remove_index :friendships, :user_id
    remove_index :conference_categories, :category_id
    remove_index :conference_categories, :conference_id
  end
end
