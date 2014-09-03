# Stores the fact that a user has invited one of her friends to attend a conference.
# origin: M
class Invitation < ActiveRecord::Base

  belongs_to :recipient, :class_name => 'User'
  belongs_to :sender, :class_name => 'User'
  belongs_to :conference

  validates_presence_of :conference_id, :recipient_id, :sender_id

  validate :recipient_must_be_a_friend

  named_scope :for_recipient, lambda { |recipient| { :conditions => { :recipient_id => recipient.id }}}
  named_scope :include_everything, :include => [:recipient, :sender, :conference]

  def accept!
    conference.attend!(recipient)
    destroy
  end

  def dismiss!
    destroy
  end

  private

  def recipient_must_be_a_friend
    if sender && recipient && !sender.friends.include?(recipient)
      errors.add(:recipient_id, 'is not a confirmed contact of the invitation sender')
    end
    true
  end

end
