# Models a registered user.
# origin: RM
class User < ActiveRecord::Base
  does 'user/authentication'
  does 'user/authorization'
  does 'user/friends'
  does 'user/search'
  does 'deletable'
  does 'sortable', :by => :username
  named_scope :by_username, :order => :username

  has_many :attendances
  has_many :conferences, :through => :attendances
  
  validates_presence_of :full_name, :town, :country, :username
  has_many :received_invitations, :class_name => 'Invitation', :foreign_key => 'recipient_id'
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'

  has_attached_file :avatar


  def sees_details_of?(other_user, force_visible = false)
    force_visible || self == other_user || friends_with?(other_user)
  end

  def username_with_full_name
    "#{username} (#{full_name})"
  end

  def name_for(other_user, force_visible = false)
    if sees_details_of?(other_user, force_visible)
      other_user.username_with_full_name
    else
      other_user.username
    end
  end

  def email_for(other_user, force_visible = false)
    if sees_details_of?(other_user, force_visible)
      other_user.email
    else
      '–'
    end
  end

  def self.create_admin!
    create! :username => 'admin',
            :password => 'admin',
            :password_confirmation => 'admin',
            :email => 'admin@plat-forms.org',
            :full_name => 'Plat_Forms 2011',
            :town => 'Nürnberg',
            :country => 'Germany',
            :role_name => 'admin'
  end

  def self.import(path)
    YAML.load(path)
  end

end
