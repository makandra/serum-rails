# Creates the table for the category model.
# origin: M
class CreateCategory < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :ancestry
      t.integer :mother_id
      t.timestamps
    end
    add_index :categories, :mother_id
  end

  def self.down
    drop_table :categories
  end
end
