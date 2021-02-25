class Event < ApplicationRecord
  belongs_to :committee
  has_many :attendance_logs
  has_many :rsvps
  has_many :attendants, class_name: 'User', through: :attendance_logs, source: :user
  has_many :rsvp_users, class_name: 'User', through: :rsvps, source: :user

  scope :by_start, -> { order(start_timestamp: :asc) }
  scope :current, -> { by_start.where('end_timestamp': DateTime.current..) }

  validates :name, presence: true, length: { minimum: 1 }
  validates :start_timestamp, presence: true
  validates :end_timestamp, presence: true
  validate :end_must_be_after_start
  validates :point_value, presence: true
  validates :passcode, presence: true, length: { minimum: 1 }
  
  def end_must_be_after_start
    errors.add(:start_timestamp, "can't start after it ends.") unless start_timestamp <= end_timestamp
  end
end
