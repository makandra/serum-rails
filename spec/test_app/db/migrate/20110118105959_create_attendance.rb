# Creates the table for the attendance model.
# origin: M
class CreateAttendance < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :conference_id
      t.timestamps
    end
    add_index :attendances, [:conference_id, :user_id], :unique => true
    add_index :attendances, :user_id
  end

  def self.down
    drop_table :attendances
  end
end
