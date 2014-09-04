# Creates the table for the invitation model.
# origin: M
class CreateInvitation < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :conference_id
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
