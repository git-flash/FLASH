class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :passcode, inclusion: { in: [self.event.passcode], message: "Passcode does not match" }
end
