class Event < ApplicationRecord

  scope :by_start, -> { order(start_timestamp: :asc) }
  scope :current, -> { by_start.where('end_timestamp': Date.current..) }
  # Ex:- scope :active, -> {where(:active => true)}

  belongs_to :committee
  has_many :users, through: :attendance_logs, source: :attendance_logs_table_foreign_key_to_objects_table
  has_many :users, through: :rsvps, source: :rsvps_table_foreign_key_to_objects_table

  validates :name, presence: true
  validates :start_timestamp, presence: true
  validates :end_timestamp, presence: true
  validate :end_must_be_after_start
  validates :point_value, presence: true
  validates :passcode, presence: true
  
  def end_must_be_after_start
    errors.add(:start_timestamp, "can't start after it ends.") unless start_timestamp <= end_timestamp
  end
end
