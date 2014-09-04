# Creates the table for the conference model.
# origin: M
class CreateConference < ActiveRecord::Migration

  def self.up
    create_table :conferences do |t|
      t.string :name
      t.text :description
      t.text :address
      t.date :start_date
      t.date :end_date
      t.integer :user_id
    end
  end

  def self.down
    drop_table :conferences
  end

end
