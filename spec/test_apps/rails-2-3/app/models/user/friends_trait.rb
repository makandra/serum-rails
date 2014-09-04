# Manages friends and friendship requests for users.
# origin: M
module User::FriendsTrait
  as_trait do

    has_many :sent_friendship_requests, :class_name => 'FriendshipRequest', :foreign_key => 'requesting_user_id'
    has_many :friendship_requests

    has_many :friendships
    has_many :friends, :through => :friendships, :order => 'username'

    def in_contact_with?(other_user)
      friends_with?(other_user) or sent_friendship_requests.collect(&:user_id).include?(other_user.id)
    end

    def friends_with?(other_user)
      friendships.collect(&:friend_id).include? other_user.id
    end

    def can_become_friends_with?(other_user)
      self != other_user and not in_contact_with? other_user
    end
    
    def status_towards(other_user)
      if friends_with?(other_user)
        'in_contact'
      elsif sent_friendship_requests.collect(&:user_id).include?(other_user.id)
        'RCD_sent'
      elsif friendship_requests.collect(&:requesting_user_id).include?(other_user.id)
        'RCD_received'
      else
        'no_contact'
      end
    end

    def contacts
      user_ids = (friend_ids + sent_friendship_requests.collect(&:user_id) + friendship_requests.collect(&:requesting_user_id)).uniq
      User.all(:conditions => {:id => user_ids})
    end

  end
end
