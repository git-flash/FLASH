class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :committee_log, ->(committee_id) { 
  select("users.first_name as first_name, users.last_name as last_name, events.name as event_name, attendance_logs.created_at as time_logged")  
    .joins("INNER JOIN events ON events.id = attendance_logs.event_id")
    .joins("INNER JOIN Committees ON committees.id = events.committee_id")
    .joins("INNER JOIN users ON users.id = attendance_logs.user_id")
    .where("committees.id = ?", committee_id) 
  }

  # TODO: fix error thrown by validate
  #validate :passcode, inclusion: { in: [self.event.passcode], message: "Passcode does not match" }
end
