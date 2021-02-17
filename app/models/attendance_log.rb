class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :user_id, uniqueness: { scope: [:event_id], message: "can't attend the same event twice." }
  validate :same_passcode?
  # validate :is_active?

  private

  def same_passcode?
    errors.add(:passcode, 'does not match.') unless passcode.eql? event.passcode
  end

  # def is_active?
  #   errors.add(:event_id, "The event isn't active.") unless event.start_timestamp < Date.now and event.end_timestamp > Date.now
  # end
end
