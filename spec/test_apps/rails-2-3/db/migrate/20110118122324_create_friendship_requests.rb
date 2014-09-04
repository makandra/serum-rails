# Creates the table for the friendship model.
# origin: M
class CreateFriendshipRequests < ActiveRecord::Migration
  def self.up
    create_table :friendship_requests do |t|
      t.integer :user_id
      t.integer :requesting_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :friendship_requests
  end
end
