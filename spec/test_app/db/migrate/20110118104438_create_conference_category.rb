# Creates the table for the join model between conferences and categories.
# origin: M
class CreateConferenceCategory < ActiveRecord::Migration

  def self.up
    create_table :conference_categories do |t|
      t.integer :conference_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :conference_categories
  end

end
