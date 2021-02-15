class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # validate :passcode, inclusion: { in: [self.event.passcode], message: 'Passcode does not match' }

  validates :user_id, presence: true
  validates :event_id, presence: true
  validate :same_passcode?

  private

  def same_passcode?
    errors.add(:passcode, 'Passcode does not match') unless passcode.eql? event.passcode
  end
end
