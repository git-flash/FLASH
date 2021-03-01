class Event < ApplicationRecord
  belongs_to :committee
  has_many :attendance_logs, :dependent => :destroy
  has_many :rsvps, :dependent => :destroy
  has_many :attendants, :class_name => 'User', :through => :attendance_logs, :source => :user
  has_many :rsvp_users, :class_name => 'User', :through => :rsvps, :source => :user

  # @return [ActiveRecord::Relation] This is a list of all the events sorted by start_timestamp.
  scope :by_start, -> { order(:start_timestamp => :asc) }
  # @return [ActiveRecord::Relation] This is a list of all events that haven't ended yet.
  scope :current, -> { by_start.where(:end_timestamp => DateTime.current..) }
  # @return [ActiveRecord::Relation] This is a list of all events that are over.
  scope :past, -> { by_start.where(start_timestamp.lt(DateTime.current)) }
  scope :month, ->(start_date) { Event.where(:start_timestamp => start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week + 1.day) }
  
  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :start_timestamp, :presence => true
  validates :end_timestamp, :presence => true
  validate :end_must_be_after_start
  validates :point_value, :presence => true
  validates :passcode, :presence => true, :length => { :minimum => 1 }
  
  def end_must_be_after_start
    errors.add(:start_timestamp, "can't start after it ends.") unless start_timestamp <= end_timestamp
  end
end
