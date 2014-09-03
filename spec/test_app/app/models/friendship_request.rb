# Stores the fact that a user has requested to be the friend of another user.
# origin: M 
class FriendshipRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :requesting_user, :class_name => 'User'

  validates_presence_of :user_id, :requesting_user_id

  # When a friendship request is accepted, two Friendship records are created (one for each direction).
  def accept
    user.friendships.create(:friend => requesting_user) and requesting_user.friendships.create(:friend => user) and destroy
  end

  def deny
    destroy
  end

end
