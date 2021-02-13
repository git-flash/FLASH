class Rsvp < ApplicationRecord
  enum rsvp_option: [:going, :not_going]

  belongs_to :user
  belongs_to :event
end
