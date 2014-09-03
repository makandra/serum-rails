class AddTimestampsToConference < ActiveRecord::Migration

  def self.up
    add_column :conferences, :created_at, :datetime
    add_column :conferences, :updated_at, :datetime
  end

  def self.down
    remove_column :conferences, :updated_at
    remove_column :conferences, :created_at
  end
end
