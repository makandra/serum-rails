# Join model to store the fact that a conference is associated with a category.
# origin: M
class ConferenceCategory < ActiveRecord::Base
  belongs_to :conference
  belongs_to :category
end
