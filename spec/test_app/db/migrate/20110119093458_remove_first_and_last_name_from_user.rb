class RemoveFirstAndLastNameFromUser < ActiveRecord::Migration

  def self.up
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def self.down
    add_column :users, :last_name
    add_column :users, :first_name
  end
end
