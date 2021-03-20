
class Rsvp < ApplicationRecord
  enum :rsvp_option => { :yes => 0, :no => 1, :maybe => 2 }

  belongs_to :user
  belongs_to :event

  validates :user_id, :presence => true
  validates :event_id, :presence => true
  validates :user_id, :uniqueness => { :scope => [:event_id], :message => "can't RSVP for the same event twice." }
  validates :rsvp_option, :inclusion => { :in => Rsvp.rsvp_options.keys }
  validate -> { errors.add(:event_id, 'expired.') unless event.in_future? }
end
