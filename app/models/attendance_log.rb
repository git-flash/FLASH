class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :user_id, uniqueness: { scope: [:event_id], message: "can't attend the same event twice." }
  validate :same_passcode?
  validate :active?

  scope :committee_log, ->(committee_id) { 
    select("users.first_name as first_name, users.last_name as last_name, events.name as event_name, attendance_logs.created_at as time_logged")  
      .joins("INNER JOIN events ON events.id = attendance_logs.event_id")
      .joins("INNER JOIN Committees ON committees.id = events.committee_id")
      .joins("INNER JOIN users ON users.id = attendance_logs.user_id")
      .where("committees.id = ?", committee_id) 
    }

    scope :user_log, ->(user_id) { 
    select("users.first_name as first_name, users.last_name as last_name, events.name as event_name, attendance_logs.created_at as time_logged")  
      .joins("INNER JOIN events ON events.id = attendance_logs.event_id")
      .joins("INNER JOIN users ON users.id = attendance_logs.user_id")
      .where("users.id = ?", user_id) 
    }

  private

  def same_passcode?
    errors.add(:passcode, 'does not match.') unless passcode.eql? event.passcode
  end

  def active?
    errors.add(:event_id, "not active.") unless event.start_timestamp < DateTime.current && event.end_timestamp > DateTime.current
  end
end
