# Stores the fact that a user is the confirmed friend of another user.
# origin: M
class Friendship < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates_presence_of :user_id, :friend_id

  def self.import(path)
    YAML.load(path)
  end

end