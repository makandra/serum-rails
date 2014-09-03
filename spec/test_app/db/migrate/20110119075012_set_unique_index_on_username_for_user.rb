# Adds an index to prevent duplicate usernames.
# origin: M
class SetUniqueIndexOnUsernameForUser < ActiveRecord::Migration
  def self.up
    add_index :users, :username, :unique => true
  end

  def self.down
    remove_index :users, :username
  end
end
