class Rsvp < ApplicationRecord
  enum :rsvp_option => { :going => 0, :not_going => 1 }

  belongs_to :user
  belongs_to :event
end
