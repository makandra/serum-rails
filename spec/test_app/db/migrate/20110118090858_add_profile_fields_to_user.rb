# Adds additional fields to the user model.
# origin: M
class AddProfileFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :town, :string
    add_column :users, :country, :string
    add_column :users, :username, :string
  end

  def self.down
    remove_column :users, :username
    remove_column :users, :country
    remove_column :users, :town
  end
end
