class Committee < ApplicationRecord
  has_many :users, :dependent => :nullify
  has_many :events, :dependent => :destroy
  has_many :user_attendance_logs, :class_name => 'AttendanceLog', :through => :users, :source => :attendance_logs
  has_many :event_attendance_logs, :class_name => 'AttendanceLog', :through => :events, :source => :attendance_logs
  has_many :user_rsvps, :class_name => 'Rsvp', :through => :users, :source => :rsvps
  has_many :event_rsvps, :class_name => 'Rsvp', :through => :events, :source => :rsvps
  has_many :user_attended_events, :class_name => 'Event', :through => :users, :source => :attended_events

  # @param [Committee] point_committee
  # @return [Integer] the total points for a certain type of committee
  def points_of_type(point_committee)
    users
      .where(:user_type => :base)
      .joins(:attended_events)
      .where(:committee => point_committee)
      .sum(:point_value)
  end

  # @return [Integer] the total points for this committee
  def total_points
    users
      .where(:user_type => :base)
      .joins(:attended_events)
      .sum(:point_value)
  end
end
